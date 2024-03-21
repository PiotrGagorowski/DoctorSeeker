class Appointment < ApplicationRecord
    has_many :user_appointments
    has_many :patients, through: :user_appointments, source: :patient
    has_many :doctors, through: :user_appointments, source: :doctor
end
