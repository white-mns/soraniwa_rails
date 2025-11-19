class NewDrop < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :drop,   :foreign_key => :drop_id,   :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :ap,     :foreign_key => :ap_no,   :primary_key => :ap_no, :class_name => 'Ap'
end
