class UserAppointment < ApplicationRecord
    belongs_to :patient, class_name: 'User', foreign_key: 'patient_user_id'
    belongs_to :appointment

    validates :appointment, presence: true
    validates :patient, presence: true, if: -> { patient_user_id.present? }
  end
  