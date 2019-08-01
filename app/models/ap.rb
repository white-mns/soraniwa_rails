class Ap < ApplicationRecord
	belongs_to :garden,   :foreign_key => :garden_id,   :primary_key => :garden_id,   :class_name => 'GardenName'
end
