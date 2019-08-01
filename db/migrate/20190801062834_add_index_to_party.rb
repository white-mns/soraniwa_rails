class AddIndexToParty < ActiveRecord::Migration[5.2]
  def change
    add_index :parties, [:ap_no, :e_no], :unique => false, :name => 'apno_eno'
    add_index :parties, :party_order
  end
end
