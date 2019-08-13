class AddColumnUseNumberToSkill < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :use_number, :integer
    add_index  :skills, :use_number
  end
end
