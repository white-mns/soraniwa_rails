class CreateDrops < ActiveRecord::Migration[5.2]
  def change
    create_table :drops do |t|
      t.integer :ap_no
      t.integer :drop_id

      t.timestamps
    end
  end
end
