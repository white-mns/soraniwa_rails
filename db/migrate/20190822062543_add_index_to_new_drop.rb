class AddIndexToNewDrop < ActiveRecord::Migration[5.2]
  def change
    add_index :new_drops, :ap_no
    add_index :new_drops, :drop_id
  end
end
