class CreateEnemyData < ActiveRecord::Migration[5.2]
  def change
    create_table :enemy_data do |t|
      t.integer :enemy_id
      t.string :name
      t.integer :line_id
      t.integer :type_id

      t.timestamps
    end
  end
end
