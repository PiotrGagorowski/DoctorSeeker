json.extract! medical_file, :id, :type, :user_id, :created_at, :updated_at
json.url medical_file_url(medical_file, format: :json)
