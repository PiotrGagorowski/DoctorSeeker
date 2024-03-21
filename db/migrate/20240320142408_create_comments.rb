class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :doctor_user_id
      t.string :file_id
      t.text :comment

      t.timestamps
    end
    add_index :comments, :doctor_user_id
    add_index :comments, :file_id
  end
end
