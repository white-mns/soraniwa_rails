class EnemyDatum < ApplicationRecord
	belongs_to :type,   :foreign_key => :type_id,   :primary_key => :type_id, :class_name => 'TypeName'
end
