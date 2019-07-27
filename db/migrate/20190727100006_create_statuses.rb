class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.integer :e_no
      t.integer :str
      t.integer :mag
      t.integer :agi
      t.integer :vit
      t.integer :dex
      t.integer :mnt
      t.integer :battle_type_id
      t.integer :battle_type_color_id
      t.integer :fan_of_flower_id
      t.integer :line_id
      t.integer :created_at

      t.timestamps
    end
  end
end