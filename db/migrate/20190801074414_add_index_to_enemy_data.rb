class AddIndexToEnemyData < ActiveRecord::Migration[5.2]
  def change
    add_index :enemy_data, :enemy_id
    add_index :enemy_data, :name
    add_index :enemy_data, :line_id
    add_index :enemy_data, :type_id
  end
end
