json.extract! user_appointment, :id, :patient_user_id, :appointment_id, :created_at, :updated_at
json.url user_appointment_url(user_appointment, format: :json)
