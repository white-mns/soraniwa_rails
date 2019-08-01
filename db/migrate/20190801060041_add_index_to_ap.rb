class AddIndexToAp < ActiveRecord::Migration[5.2]
  def change
    add_index :aps, :ap_no, :unique => true
    add_index :aps, [:created_at, :ap_no], :unique => false, :name => 'createdat_apno'
    add_index :aps, :action_type
    add_index :aps, :garden_id
    add_index :aps, :progress
    add_index :aps, :party_num
    add_index :aps, :enemy_num
    add_index :aps, :battle_result
    add_index :aps, :special_battle
    add_index :aps, :is_practice
    add_index :aps, :created_at
  end
end
