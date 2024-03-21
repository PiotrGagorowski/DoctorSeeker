class AddForeignKeysToTables < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key "user_appointments", "users", column: "doctor_user_id"
    add_foreign_key "user_appointments", "users", column: "patient_user_id"
    add_foreign_key "user_reviews", "users", column: "doctor_user_id"
    add_foreign_key "user_reviews", "users", column: "patient_user_id"
    add_foreign_key "medical_files", "users", column: "user_id"
    add_foreign_key "comments", "users", column: "doctor_user_id"
    add_foreign_key "comments", "medical_files", column: "file_id"
  end
end