class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.integer :ap_no
      t.integer :e_no
      t.integer :party_order

      t.timestamps
    end
  end
end
