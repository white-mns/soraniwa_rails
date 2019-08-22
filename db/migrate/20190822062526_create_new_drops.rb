class CreateNewDrops < ActiveRecord::Migration[5.2]
  def change
    create_table :new_drops do |t|
      t.integer :ap_no
      t.integer :drop_id

      t.timestamps
    end
  end
end
