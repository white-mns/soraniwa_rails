class AddIndexToStatus < ActiveRecord::Migration[5.2]
  def change
    add_index :statuses, [:e_no, :created_at], :unique => false, :name => 'createdat_and_eno'
    add_index :statuses, :str
    add_index :statuses, :mag
    add_index :statuses, :agi
    add_index :statuses, :vit
    add_index :statuses, :dex
    add_index :statuses, :mnt
    add_index :statuses, :battle_type_id
    add_index :statuses, :battle_type_color_id
    add_index :statuses, :fan_of_flower_id
    add_index :statuses, :line_id
    add_index :statuses, :created_at
  end
end
