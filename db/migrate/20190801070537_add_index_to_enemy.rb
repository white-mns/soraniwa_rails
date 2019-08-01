class AddIndexToEnemy < ActiveRecord::Migration[5.2]
  def change
    add_index :enemies, :ap_no
    add_index :enemies, :enemy_id
    add_index :enemies, :suffix_id
  end
end
