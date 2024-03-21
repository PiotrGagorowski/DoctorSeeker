class UserAppointmentsController < ApplicationController
  before_action :set_user_appointment, only: %i[ show edit update destroy ]

  # GET /user_appointments or /user_appointments.json
  def index
    @user_appointments = UserAppointment.all
  end

  # GET /user_appointments/1 or /user_appointments/1.json
  def show
  end

  # GET /user_appointments/new
  def new
    @user_appointment = UserAppointment.new
  end

  # GET /user_appointments/1/edit
  def edit
  end

  # POST /user_appointments or /user_appointments.json
  def create
    @user_appointment = UserAppointment.new(user_appointment_params)

    respond_to do |format|
      if @user_appointment.save
        format.html { redirect_to user_appointment_url(@user_appointment), notice: "User appointment was successfully created." }
        format.json { render :show, status: :created, location: @user_appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_appointments/1 or /user_appointments/1.json
  def update
    respond_to do |format|
      if @user_appointment.update(user_appointment_params)
        format.html { redirect_to user_appointment_url(@user_appointment), notice: "User appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @user_appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_appointments/1 or /user_appointments/1.json
  def destroy
    @user_appointment.destroy!

    respond_to do |format|
      format.html { redirect_to user_appointments_url, notice: "User appointment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_appointment
      @user_appointment = UserAppointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_appointment_params
      params.require(:user_appointment).permit(:patient_user_id, :appointment_id, :doctor_user_id)
    end
end
