class AddIndexToDrop < ActiveRecord::Migration[5.2]
  def change
    add_index :drops, :ap_no
    add_index :drops, :drop_id
  end
end
