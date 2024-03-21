class Comment < ApplicationRecord
    belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_user_id'
    belongs_to :file, class_name: 'MedicalFile', foreign_key: 'file_id'
  end