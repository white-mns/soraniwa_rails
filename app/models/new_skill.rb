class NewSkill < ApplicationRecord
	belongs_to :skill,  :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => 'SkillDatum'
end
