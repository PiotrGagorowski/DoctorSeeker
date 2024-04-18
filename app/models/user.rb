class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :appointments_as_doctor, class_name: 'Appointment', foreign_key: 'doctor_user_id'
  has_many :appointments_as_patient, class_name: 'UserAppointment', foreign_key: 'patient_user_id'
  has_many :appointments, through: :appointments_as_doctor, source: :appointments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   enum role: [:patient, :admin, :doctor, :labworker]
   after_initialize :set_default_role, :if => :new_record?

   validates :pesel_number, length: { is: 11}

   def set_default_role
    self.role ||= :patient
   end
end
