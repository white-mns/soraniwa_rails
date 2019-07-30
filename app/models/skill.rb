class Skill < ApplicationRecord
	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :status, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Status'
	belongs_to :type,   :foreign_key => :type_id,   :primary_key => :type_id,   :class_name => 'TypeName'
	belongs_to :nature, :foreign_key => :nature_id, :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :timing, :foreign_key => :timing_id, :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :skill,  :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => 'SkillDatum'
end
