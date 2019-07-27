module ApplicationHelper
    def page_title
        title = "ソラニワデータ小屋"
        title = @page_title + " | " + title if @page_title
        title
    end

    def top_result_no(result_no,generate_no)
        if !result_no then return "-" end
        text = ""
        generate_text = ""
        generate_text = "再" if generate_no > 0
        num = 2
        while num <= generate_no do
            num += 1
            generate_text += "々"
        end
        text = sprintf("%d", result_no) + "回" + generate_text
        text
    end

    def pc_name_text(e_no, pc_name)
        e_no_text = "(" + sprintf("%d",e_no) + ")"
        if pc_name then
            pc_name.name.html_safe + e_no_text
        else
            e_no_text
        end
    end

    def character_link(e_no)
        if e_no <= 0 then return end

        file_name = sprintf("%d",e_no)
        link_to " キャラクター", "http://st.x0.to/?mode=profile&eno="+file_name+"", :target => "_blank"
    end
    
    def character_old_link(latest_result_no, e_no, result_no, generate_no)
        if e_no <= 0 then return end
        if result_no == latest_result_no then return end

        result_no_text = sprintf("%03d", result_no)
        generate_text  = generate_no > 0 ? "_" + sprintf("%d", generate_no) : ""
        file_name = sprintf("%d", e_no)
        link_to " 結果", "https://xxx.xxx/"+result_no_text+generate_text+"/"+file_name+".html", :target => "_blank"
    end

    def search_submit_button()
        haml_tag :button, class: "btn submit", type: "submit" do
            haml_concat fa_icon "search", text: "検索する"
        end
    end

    def help_icon()
        haml_concat fa_icon "question-circle"
    end

    def act_desc(is_opened)
        desc        = is_opened ? "（クリックで閉じます）" : "（クリックで開きます）"
        desc_closed = is_opened ? "（クリックで開きます）" : "（クリックで閉じます）"

        haml_tag :span, class: "act_desc" do
            haml_concat desc
        end

        haml_tag :span, class: "act_desc closed" do
            haml_concat desc_closed
        end
    end

    def act_icon(is_opened)
        icon        = is_opened ? "times" : "plus"
        icon_closed = is_opened ? "plus"  : "times"

        haml_tag :span, class: "act_desc" do
            haml_concat fa_icon icon, class: "fa-lg"
        end

        haml_tag :span, class: "act_desc closed" do
            haml_concat fa_icon icon_closed, class: "fa-lg"
        end
    end

    def td_form(f, form_params, placeholders, class_name: nil, colspan: nil, label: nil, params_name: nil, placeholder: nil, checkboxes: nil, label_td_class_name: nil)
        haml_tag :td, class: label_td_class_name do
            if label then
                haml_concat f.label params_name.to_sym, label
            end
        end

        # テキストフォームの描画
        if !class_name.nil? && !params_name.nil?  then
            td_text_form(f, form_params, placeholders, class_name: class_name, colspan: colspan, params_name: params_name, placeholder: placeholder)
        end

        # チェックボックス選択フォームの描画
        if !checkboxes.nil?  then
            td_text_checkbox(f, form_params, placeholders, class_name: class_name, colspan: colspan, checkboxes: checkboxes)
        end
    end
    def td_text_form(f, form_params, placeholders, class_name: nil, colspan: nil, params_name: nil, placeholder: nil)
        haml_tag :td, class: class_name, colspan: colspan do
            haml_concat text_field_tag params_name.to_sym, form_params[params_name], placeholder: placeholders[placeholder]
        end
    end

    def td_text_checkbox(f, form_params, placeholders, class_name: nil, colspan: nil, checkboxes: [])
        haml_tag :td, class: class_name, colspan: colspan do
            checkboxes.each do |hash|
                # チェックボックスの描画
                if !hash[:params_name].nil? then
                    haml_tag :span, class: hash[:class_name] do
                        haml_concat check_box_tag hash[:params_name].to_sym, form_params[hash[:params_name]], form_params[hash[:params_name]]
                        haml_concat label_tag hash[:params_name].to_sym, hash[:label]
                    end
                end

                # 改行指定
                if hash[:br] then
                    haml_tag :br
                end
            end
        end
    end

    def td_date_between_form(f, form_params, placeholders, class_name: nil, colspan: nil, label: nil, params_name: nil, placeholder: nil, checkboxes: nil, label_td_class_name: nil, data_target: nil)
        haml_tag :td, class: label_td_class_name do
            if label then
                haml_concat f.label params_name.to_sym, label
            end
        end

        # 日付選択フォームの描画
        if !params_name.nil?  then
            haml_tag :td, class: class_name, colspan: colspan do
                div_date_form(f, form_params, placeholders, class_name: class_name, colspan: colspan, params_name: params_name + "_gteq_form", placeholder: placeholder, data_target: data_target + "_gteq")
                haml_concat "　～　"
                div_date_form(f, form_params, placeholders, class_name: class_name, colspan: colspan, params_name: params_name + "_lteq_form", placeholder: placeholder, data_target: data_target + "_lteq")
            end
        end
    end

    def div_date_form(f, form_params, placeholders, class_name: nil, colspan: nil, params_name: nil, placeholder: nil, data_target: nil)
        haml_tag :div, class: "input-group date datepicker", id: data_target, style: "width:12rem; display:inline-block;", data: {target: {input: "nearest"}} do
            haml_concat text_field_tag params_name.to_sym, form_params[params_name], class: "form-control datetimepicker-input", style:"width:10rem; float:left;", data: {target: "#" + data_target}, placeholder: placeholders[placeholder]
            haml_tag :div, class: "input-group-append", data: {target: "#" + data_target, toggle: "datetimepicker"} do
                haml_tag :div, class: "input-group-text" do
                    haml_tag :i, class: "fa fa-calendar"
                end
            end
        end
    end


    def tbody_toggle(form_params, params_name: nil, label: {open: "", close: ""}, act_desc: nil, base_first: false)
        haml_tag :tbody, class: "tbody_toggle pointer"do
            haml_tag :tr do
                haml_tag :td, colspan: 5 do
                    if base_first then
                        haml_concat hidden_field_tag :base_first, form_params["base_first"]
                    end

                    haml_concat hidden_field_tag params_name.to_sym, form_params[params_name]

                    act_icon(false)

                    haml_concat label_tag params_name.to_sym, "　" + label[:open],  class: "act_desc"
                    haml_concat label_tag params_name.to_sym, "　" + label[:close], class: "act_desc closed"
                    if act_desc then
                        haml_tag :div, class: "act_desc" do
                           haml_concat "　" + act_desc
                        end
                    end
                end
            end
        end
    end

    def battle_type_border(object)
        if !object then 
            return
        end

        border_colors = ["#ff2222","#449922","#2222cc","#cc2222","#bbbb00","#f09966","#25bf8b","#ffb050","#ab5de7","#88bbff","#30d0ee","#55f077","#ddbb60","#bb6640","#664ff5","#999999","#f96c24"]
        border_style = ""
        border_style = "0.2rem " + border_colors[object.battle_type_color_id] + " solid"

        "border-left: " + border_style;
    end
end
