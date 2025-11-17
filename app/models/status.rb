class Status < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :type,   :foreign_key => :type_id,   :primary_key => :type_id, :class_name => 'TypeName'
	belongs_to :fan_of_flower, :foreign_key => :fan_of_flower_id, :primary_key => :proper_id, :class_name => 'ProperName'

    # 人数グラフの表示
    scope :to_sum_graph_type_id, -> (column) {
        propers_name = Hash[*TypeName.pluck(:type_id, :name).flatten]
        pluck(column).inject(Hash.new(0)){|hash, a| hash[propers_name[a]] += 1 ; hash}.sort_by{ |k, v| v}
    }
end
