class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :appointments_as_doctor, class_name: 'Appointment', foreign_key: 'doctor_user_id'
  has_many :appointments_as_patient, class_name: 'UserAppointment', foreign_key: 'patient_user_id'
  has_many :appointments, through: :appointments_as_doctor, source: :appointments
  has_many :appointments, through: :user_appointments
  has_many :medical_files
  has_many :user_appointments
  has_many :user_reviews
  has_many :reviews, through: :user_reviews

   enum role: [:patient, :admin, :doctor, :labworker]
   after_initialize :set_default_role, :if => :new_record?

   validates :pesel_number, presence: true, length: { is: 11 }, format: { with: /\A\d{11}\z/, message: "Musi zawierać dokładnie 11 cyfr" }

   def set_default_role
    self.role ||= :patient
   end

   def send_reset_password_instructions
       token = set_reset_password_token
       Devise::Mailer.reset_password_instructions(self, token).deliver_later
     end
     
     
  # Validating password complexity
  validate :password_complexity

  def password_complexity
    if password.present? && !password.match(/\A(?=.*[A-Z])(?=.*\d)/)
      errors.add :password, "musi zawierać co najmniej jedną dużą literę i jedną cyfrę"
    end
  end


     
end
