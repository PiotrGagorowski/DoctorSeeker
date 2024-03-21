class CreateUserReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :user_reviews do |t|
      t.string :patient_user_id
      t.string :doctor_user_id
      t.string :review_id

      t.timestamps
    end
    add_index :user_reviews, :patient_user_id
    add_index :user_reviews, :doctor_user_id
    add_index :user_reviews, :review_id
  end
end
