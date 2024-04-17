# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_27_123715) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "appointment_date"
    t.bigint "doctor_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_user_id"], name: "index_users_on_doctor_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "doctor_user_id"
    t.bigint "file_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_user_id"], name: "index_comments_on_doctor_user_id"
    t.index ["file_id"], name: "index_comments_on_file_id"
  end

  create_table "medical_files", force: :cascade do |t|
    t.integer "category"
    t.bigint "user_id", null: false
    t.bigint "additional_user_id", null: true
    t.bigint "file_id", null: false
    t.date "utility_date", null: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_medical_files_on_user_id"
    t.index ["file_id"], name: "index_medical_files_on_active_storage_attachments_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "score"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_appointments", force: :cascade do |t|
    t.bigint "patient_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "appointments_id"
    t.index ["appointments_id"], name: "index_user_appointments_on_appointments_id"
    t.index ["patient_user_id"], name: "index_user_appointments_on_patient_user_id"
  end

  create_table "user_reviews", force: :cascade do |t|
    t.bigint "patient_user_id"
    t.bigint "doctor_user_id"
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_user_id"], name: "index_user_reviews_on_doctor_user_id"
    t.index ["patient_user_id"], name: "index_user_reviews_on_patient_user_id"
    t.index ["review_id"], name: "index_user_reviews_on_review_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "pesel_number"
    t.text "about"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "medical_files", column: "file_id"
  add_foreign_key "comments", "users", column: "doctor_user_id"
  add_foreign_key "medical_files", "users", column: "user_id"
  add_foreign_key "medical_files", "users", column: "additional_user_id"
  add_foreign_key "user_appointments", "appointments", column: "appointments_id"
  add_foreign_key "appointments", "users", column: "doctor_user_id"
  add_foreign_key "user_appointments", "users", column: "patient_user_id"
  add_foreign_key "user_reviews", "reviews"
  add_foreign_key "user_reviews", "users", column: "doctor_user_id"
  add_foreign_key "user_reviews", "users", column: "patient_user_id"
  add_foreign_key "medical_files", "active_storage_attachments", column: "file_id"
end
