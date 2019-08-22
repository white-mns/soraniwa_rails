class CreateNewSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :new_skills do |t|
      t.integer :skill_id

      t.timestamps
    end
  end
end
