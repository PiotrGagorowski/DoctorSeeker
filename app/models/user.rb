class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_appointments_as_patient, class_name: 'UserAppointment', foreign_key: 'patient_user_id'
  has_many :user_appointments_as_doctor, class_name: 'UserAppointment', foreign_key: 'doctor_user_id'

  has_many :appointments_as_patient, through: :user_appointments_as_patient, source: :appointment
  has_many :appointments_as_doctor, through: :user_appointments_as_doctor, source: :appointment

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         enum role: [:patient, :admin, :doctor, :labworker]
         after_initialize :set_default_role, :if => :new_record?

         def set_default_role
          self.role ||= :patient
         end
end
