class CreateGardenNames < ActiveRecord::Migration[5.2]
  def change
    create_table :garden_names do |t|
      t.integer :garden_id
      t.string :name

      t.timestamps
    end
  end
end
