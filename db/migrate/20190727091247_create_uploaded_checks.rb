class CreateUploadedChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :uploaded_checks do |t|

      t.timestamps
    end
  end
end
