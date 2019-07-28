class AddIndexToTypeName < ActiveRecord::Migration[5.2]
  def change
    add_index :type_names, :type_id
    add_index :type_names, :name
  end
end
