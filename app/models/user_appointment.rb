class UserAppointment < ApplicationRecord
    belongs_to :patient, class_name: 'User', foreign_key: 'patient_user_id'
    belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_user_id'
    belongs_to :appointment
end
