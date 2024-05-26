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

    if overlapping_appointments?(@user_appointment)
      flash[:alert] = "Twoje nowe wizyty się pokrywają z istniejącymi. Nie możesz mieć dwóch wizyt jednocześnie."
      redirect_to patient_path
      return
    end

    respond_to do |format|
      if @user_appointment.save
        format.html { redirect_to patient_appointments_path, alert: "Zostałeś pomyślnie zapisany na wizytę." }
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
    @user_appointment = UserAppointment.find(params[:id])
  
  if @user_appointment
    @user_appointment.destroy
    notice_message = 'Your appointment has been canceled.'
  else
    notice_message = 'You are not authorized to cancel this appointment.'
  end

    respond_to do |format|
      format.html { redirect_to patient_appointments_path, alert: "Twoja wizyta została pomyślnie usunięta." }
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
      params.require(:user_appointment).permit(:patient_user_id, :appointment_id)
    end

    def overlapping_appointments?(new_appointment)
      new_appointment_start_time = new_appointment.appointment.start_time
      new_appointment_end_time = new_appointment_start_time + 30.minutes
      existing_appointments = UserAppointment.where(patient_user_id: current_user.id)
    
      existing_appointments.each do |existing_user_appointment|
        existing_appointment_start_time = existing_user_appointment.appointment.start_time
        existing_appointment_end_time = existing_appointment_start_time + 30.minutes
    
        if (new_appointment_start_time..new_appointment_end_time).overlaps?(existing_appointment_start_time..existing_appointment_end_time)
          return true
        end
      end
    
      false
    end
    
end
