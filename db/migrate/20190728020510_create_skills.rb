class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.integer :e_no
      t.integer :set_no
      t.integer :skill_type_id
      t.integer :type_id
      t.integer :nature_id
      t.integer :skill_id
      t.string :name
      t.integer :timing_id

      t.timestamps
    end
  end
end
