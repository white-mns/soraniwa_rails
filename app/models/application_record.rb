class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :notnil, -> () {
    where.not(result_no: nil)
  }

  scope :notnil_date, -> () {
    where.not(created_at: nil)
  }

  # 検索ヒット件数の取得
  #   通常時：      整数
  #   グループ化時：ハッシュのキーの数(グループ化後のヒット数)
  scope :hit_count, -> () {
    if count().kind_of?(Hash) then
        count().keys().size
    else
        count()
    end
  }

  # 人数グラフの表示
  scope :to_sum_graph, -> (column) {
      pluck(column).inject(Hash.new(0)){|hash, a| hash[a] += 1 ; hash}.sort_by{ |k, v| v}
  }

  # 人数グラフの表示(値=固有名詞IDのとき、固有名詞をラベルとして表示)
  scope :to_sum_graph_proper_id, -> (column) {
      proper_name = Hash[*ProperName.pluck(:proper_id, :name).flatten]
      pluck(column).inject(Hash.new(0)){|hash, a| hash[proper_name[a]] += 1 ; hash}.sort_by{ |k, v| v}
  }

  # ヒストグラムの表示
  scope :to_range_graph, -> (column) {
      max = self.pluck(column).max
      figure_length = max.to_s.length # 最大桁数の取得
      
      if !max then return nil end

      range = (max / 20).to_i
      floor_num = (10 ** (range.to_s.length - 1))
      range = (range / floor_num).to_i # 範囲の最上位桁の値を1,2,5のいずれかにする
      range = range <= 2 ? range : 5
      range = range * floor_num

      if range == 0 then range = 1 end
      
      pluck(column).inject(Hash.new(0)){|hash, a| floor= (a/range).to_i()*range; hash[floor.to_s.rjust(figure_length) + "～" + (floor+range).to_s.rjust(figure_length)] += 1 ; hash}.sort
  }

  # ヒストグラムの表示（最低値を0以外で指定）
  scope :to_range_variable_min_graph, -> (column) {
      max = self.pluck(column).max
      min = self.pluck(column).min

      if !max then return nil end

      figure_length = max.to_s.length # 最大桁数の取得
      
      range = ((max - min) / 20).to_i
      floor_num = (10 ** (range.to_s.length - 1))
      range = (range / floor_num).to_i # 範囲の最上位桁の値を1,2,5のいずれかにする
      range = range <= 2 ? range : 5
      range = range * floor_num

      if range == 0 then range = 1 end
      
      pluck(column).inject(Hash.new(0)){|hash, a| floor= (a/range).to_i()*range; hash[floor.to_s.rjust(figure_length) + "～" + (floor+range).to_s.rjust(figure_length)] += 1 ; hash}.sort
  }
end
