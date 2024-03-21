class Review < ApplicationRecord
    has_one :user_review
    has_one :patient, through: :user_review
    has_one :doctor, through: :user_review
  end