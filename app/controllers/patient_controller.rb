class PatientController < ApplicationController
    def patient
      @user_appointment = UserAppointment.new
  
      # Separate reserved and free appointments
      @reserved_appointments = Appointment.reserved.includes(:user_appointments)
      @free_appointments = Appointment.free
  
    end
  
    def user_appointment_params
      params.require(:user_appointment).permit(:patient_user_id, :appointment_id)
    end
  end
  