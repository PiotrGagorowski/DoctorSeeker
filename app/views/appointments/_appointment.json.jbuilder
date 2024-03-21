json.extract! appointment, :id, :appointment_date, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
