class Status < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :type,   :foreign_key => :type_id,   :primary_key => :type_id, :class_name => 'TypeName'
	belongs_to :fan_of_flower, :foreign_key => :fan_of_flower_id, :primary_key => :proper_id, :class_name => 'ProperName'
end
