class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]

  # GET /appointments or /appointments.json
  def index
    if current_user.doctor?
      @appointments = current_user.appointments_as_doctor
    else
      @reserved_appointments = Appointment.reserved.includes(:user_appointments)
      @free_appointments = Appointment.free
    end
  end
  
  # GET /appointments/1 or /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end
  def appointments
    @appointments = current_user.appointments.all
  end
  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.doctor_user_id = current_user.id
    respond_to do |format|
      if @appointment.save
        format.html { redirect_to set_appointment_path, notice: "Dodałeś nowy termin wizyty." }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully updated." }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    AppointmentMailer.with(appointment: @appointment).appointment_deleted.deliver_later
    @appointment.destroy!

    respond_to do |format|
      format.html { redirect_to doctor_path, notice: "Wizyta została poprawnie usunięta" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.permit(:start_time, :end_time)
    end
end
