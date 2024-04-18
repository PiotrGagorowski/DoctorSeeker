class Appointment < ApplicationRecord
    belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_user_id'
    has_many :user_appointments
    has_many :patients, through: :user_appointments, source: :patient

    scope :reserved, -> { joins(:user_appointments).distinct }
    scope :free, -> { where.not(id: joins(:user_appointments).select(:appointment_id)) }
  
  end