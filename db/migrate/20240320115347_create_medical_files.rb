class CreateMedicalFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :medical_files do |t|
      t.integer :type
      t.string :user_id

      t.timestamps
    end
    add_index :medical_files, :user_id
  end
end
