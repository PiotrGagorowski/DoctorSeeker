class UserReviewsController < ApplicationController
  before_action :set_user_review, only: %i[ show edit update destroy ]

  # GET /user_reviews or /user_reviews.json
  def index
    @user_reviews = UserReview.all
  end

  # GET /user_reviews/1 or /user_reviews/1.json
  def show
  end

  # GET /user_reviews/new
  def new
    @user_review = UserReview.new
    @user_review.build_review
  end

  # GET /user_reviews/1/edit
  def edit
  end

  # POST /user_reviews or /user_reviews.json
  def create
    doctor_id = user_review_params[:doctor_user_id]
    existing_review = UserReview.find_by(patient_user_id: current_user.id, doctor_user_id: doctor_id)

    if existing_review
      respond_to do |format|
        format.html { redirect_to patient_reviews_path, alert: "Już wystawiłeś recenzję dla tego lekarza." }
        format.json { render json: { error: "You have already reviewed this doctor." }, status: :unprocessable_entity }
      end
    else
      @user_review = UserReview.new(user_review_params)
      @user_review.patient_user_id = current_user.id

      respond_to do |format|
        if @user_review.save
          format.html { redirect_to patient_reviews_path, alert: "Recenzja została pomyślnie dodana." }
          format.json { render :show, status: :created, location: @user_review }
        else
          format.html { redirect_to patient_reviews_path, alert: "Musisz wprowadzic wartości we wszytskie pola formularza w celu dodania recenzji."  }
          format.json { render json: @user_review.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /user_reviews/1 or /user_reviews/1.json
  def update
    respond_to do |format|
      if @user_review.update(user_review_params)
        format.html { redirect_to user_review_url(@user_review), notice: "User review was successfully updated." }
        format.json { render :show, status: :ok, location: @user_review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_reviews/1 or /user_reviews/1.json
  def destroy
    @user_review.destroy!
    @user_review.review.destroy if @user_review.review.present?

    respond_to do |format|
      format.html { redirect_to patient_reviews_path, notice: "Recenzja została pomyślnie usunięta." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_review
      @user_review = UserReview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_review_params
      params.require(:user_review).permit(:patient_user_id, :doctor_user_id, review_attributes: [:score, :comment])
    end
end
