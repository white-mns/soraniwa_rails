class NewDrop < ApplicationRecord
	belongs_to :drop,   :foreign_key => :drop_id,   :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :ap,     :foreign_key => :ap_no,   :primary_key => :ap_no, :class_name => 'Ap'
end
