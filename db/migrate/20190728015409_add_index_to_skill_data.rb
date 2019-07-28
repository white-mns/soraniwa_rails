class AddIndexToSkillData < ActiveRecord::Migration[5.2]
  def change
    add_index :skill_data, :skill_id
    add_index :skill_data, :name
    add_index :skill_data, :cost_id
  end
end
