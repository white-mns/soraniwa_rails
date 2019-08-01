class CreateAps < ActiveRecord::Migration[5.2]
  def change
    create_table :aps do |t|
      t.integer :ap_no
      t.integer :action_type
      t.integer :garden_id
      t.integer :progress
      t.integer :party_num
      t.integer :enemy_num
      t.integer :battle_result
      t.integer :special_battle
      t.integer :is_practice

      t.timestamps
    end
  end
end
