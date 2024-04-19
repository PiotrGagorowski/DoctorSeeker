class MainController < ApplicationController
  def login
  end

  def doctors
  @doctors = User.where(role: :doctor)
  end

  def show
    @doctor = User.find(params[:id])
    @user_reviews = UserReview.where(doctor_user_id: @doctor.id)
    @reviews = @user_reviews.map(&:review)
    @average_score = @reviews.present? ? @reviews.average(:score).to_f : 0.0
  end

end
