module MyUtility
  # クエリパラメータをRunsuck検索用関数とフォーム表示用変数に渡す
  def params_to_form(params, form_params, column_name: nil, params_name: nil, type: nil)
      if type == "number" then
        function = method(:reference_number_assign)

      elsif type == "text" then
        function = method(:reference_text_assign)
      end

      if function then
        function.call(params, column_name, params_name)
      end

      form_params[ params_name ] = params[ params_name ]
  end

  # 選択式チェックボックスから取得したクエリパラメータをRunsuck検索用クエリに渡す
  def checkbox_params_set_query_any(params, form_params, query_name: nil, checkboxes: nil)
    params[:q][query_name] = []
    if !params["is_form"] then
        checkboxes.each do |hash|
            if hash[:first_checked] then
                if params[ hash[:params_name] ] == "off" then
                    params.delete( hash[:params_name] )
                else
                    params[ hash[:params_name] ] = "on"
                end
            end
        end
    end

    checkboxes.each do |hash|
        if params[ hash[:params_name] ] == "on" then params[:q][query_name].push(hash[:value]) end
        form_params[ hash[:params_name] ] = params[ hash[:params_name] ]
    end
  end

  # 単一条件チェックボックスから取得したクエリパラメータをRunsuck検索用クエリに渡す
  def checkbox_params_set_query_single(params, form_params, query_name: nil, checkbox: nil)
    if !params["is_form"] then
        if checkbox[:first_checked] then
            params[ checkbox[:params_name] ] = "on"
        end
    end

    if params[ checkbox[:params_name] ] == "on" then params[:q][checkbox[:query_name]] = checkbox[:value] end
    form_params[ checkbox[:params_name] ] = params[ checkbox[:params_name] ]
  end

  # 開閉情報のクエリパラメータ受け渡し
  def toggle_params_to_variable(params, form_params, params_name: nil, first_opened: false)
      form_params[ params_name ] = (!params["is_form"] && first_opened) ? "1" : params[ params_name ]
  end

  # 検索文字列を分割し、Ransackが参照する配列に割り当てる
  def reference_word_assign(params, data_name, param_key, match_suffix)
    if(!params[param_key]) then
        return
    end

    texts = (params[param_key].match(/ /)) ? params[param_key].gsub(/[“”]/, "\"").split(" ") : [params[param_key].dup.gsub(/[“”]/,"\"")]

    if texts.is_a?(Array) then
        for text in texts do
            if (text && text.match("/")) then
                texts_or = text.split("/")
                for text_or in texts_or do
                    reference_word_set(params, data_name, text_or, match_suffix, "any") 
                end
            else
                reference_word_set(params, data_name, text, match_suffix, "all") 
            end
        end
    end
  end

  def reference_text_assign(params, data_name, param_key)
    reference_word_assign(params, data_name, param_key, "cont")
  end

  # 文字列の除外と完全一致を判定し、Ransackが参照する配列に割り当てる
  def reference_word_set(params, data_name, text, match_suffix, operator_suffix)
      not_suffix = ""
      if(text[0] == "-") then
          # 除外検索用に添字を変更 「_not_cont_all」か「not_eq_all」になる
          text.slice!(0,1)
          not_suffix = "not_"
          operator_suffix = "all"
          data_name = data_name.gsub(/_or_/, "_and_")
      end
      
      if(text[0] == "\"" && text[-1] == "\"") then
          # 完全一致に添字を変更
          text.slice!(0,1)
          text.slice!(-1,1)
          match_suffix = "eq"
      end
      
      param_push(params, data_name + "_" + not_suffix + match_suffix + "_" + operator_suffix, text)

  end
  
  # 数値の文字列を分割し、Ransackが参照する配列に割り当てる
  def reference_number_assign(params, data_name, param_key)
    if(!params[param_key]) then
        return
    end

    texts = (params[param_key].match("/")) ? params[param_key].split("/") : [params[param_key].dup]

    if texts.is_a?(Array) then
        for text in texts do
            if (text && text.match(/([\-\.\d]+)~([\-\.\d]+)/)) then
                text_match = text.match(/([\-\.\d]+)~([\-\.\d]+)/)
                reference_number_set(params, data_name, text_match[0] + "~") 
                reference_number_set(params, data_name, "~" + text_match[2]) 
            else
                reference_number_set(params, data_name, text) 
            end
        end
    end
  end

  # 数値の文字列から以上・以下を判定し、Ransackが参照する配列に割り当てる
  def reference_number_set(params, data_name, text)
      match_suffix = "eq"
      if(text[0] == "~") then
          text.slice!(0,1)
          match_suffix = "lteq"
      end
      
      if(text[-1] == "~") then
          text.slice!(-1,1)
          match_suffix = "gteq"
      end
      
      param_push(params, data_name + "_" + match_suffix + "_any", text)
  end
 
  # Ransackの検索用パラメータに追加。配列がない場合は作成する 
  def param_push(params, ransack_param, text)
      if !params[:q][ransack_param].is_a?(Array) then
          params[:q][ransack_param] = Array.new
      end

      params[:q][ransack_param].push(text)
  end

  def params_clean(params)
    if params[:q] && params[:q][:s] then
        sort = params[:q][:s]
    end

    params[:q] = {}

    if sort then
        params[:q][:s] = sort
    end
  end

  # has_manyで結合した要素について、AND検索で絞り込む
  # 　・取得した配列に対して積集合を繰り返し、残ったデータのみを取り出し返す
  def add_and_param_for_has_many(params, params_tmp, detection_arrays, dummy_param, param, record, column)
    if params[:q][dummy_param] then
        params[:q][dummy_param].each do |tmp_param|
            params_tmp[:q][param] = tmp_param
            nos = record.search(params_tmp[:q]).result.pluck(column).uniq
            if detection_arrays[:and].length > 1 then 
                detection_arrays[:and] = detection_arrays[:and] & nos

                # 絞り込んだ結果ヒット件数が0になった場合、ダミー値で絞り込ませる
                # 　0件で配列を返すと、絞り込みが行われず全件ヒットするため
                if detection_arrays[:and].length == 0 then 
                    detection_arrays[:and] = [-99999]
                    return
                end
            else
                detection_arrays[:and] += nos
            end
            params_tmp[:q].delete(param)
        end
    end
  end

  # has_manyで結合した要素について、OR検索で絞り込む
  def add_or_param_for_has_many(params, params_tmp, detection_arrays, dummy_param, param, record, column)
    if params[:q][dummy_param] then
        params_tmp[:q][param] = params[:q][dummy_param]
        nos = record.search(params_tmp[:q]).result.pluck(column)
        detection_arrays[:or] += nos
        params_tmp[:q].delete(param)
    end
  end

  # has_manyで結合した要素について、NT検索で絞り込む
  def add_not_param_for_has_many(params, params_tmp, detection_arrays, dummy_param, param, record, column)
    if params[:q][dummy_param] then
        params[:q][dummy_param].each do |tmp_param|
            params_tmp[:q][param] = tmp_param
            nos = record.search(params_tmp[:q]).result.pluck(column).uniq
            if detection_arrays[:not].length > 1 then 
                detection_arrays[:not] = detection_arrays[:not] & nos

            else
                detection_arrays[:not] += nos
            end
            params_tmp[:q].delete(param)
        end
    end
  end

  private

end
