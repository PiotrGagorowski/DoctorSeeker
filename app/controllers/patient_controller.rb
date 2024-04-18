class PatientController < ApplicationController

    def patient
        @appointments = Appointment.all
        @user_appointment = UserAppointment.new
        @reserved_appointments = Appointment.reserved.includes(:user_appointments)
        @free_appointments = Appointment.free
    end
    def user_appointment_params
        params.require(:user_appointment).permit(:patient_user_id, :appointments_id)
    end
end

