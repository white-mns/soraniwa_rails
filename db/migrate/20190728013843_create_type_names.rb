class CreateTypeNames < ActiveRecord::Migration[5.2]
  def change
    create_table :type_names do |t|
      t.integer :type_id
      t.string :name

      t.timestamps
    end
  end
end
