class AddIndexToGardenName < ActiveRecord::Migration[5.2]
  def change
    add_index :garden_names, :garden_id
    add_index :garden_names, :name
  end
end
