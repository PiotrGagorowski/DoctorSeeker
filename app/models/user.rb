class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         enum role: [:patient, :admin, :doctor, :labworker]
         after_initialize :set_default_role, :if => :new_record?
         

         validates :pesel_number, length: { is: 11}

         def set_default_role
          self.role ||= :patient
         end
end
