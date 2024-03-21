json.extract! user_review, :id, :patient_user_id, :doctor_user_id, :review_id, :created_at, :updated_at
json.url user_review_url(user_review, format: :json)
