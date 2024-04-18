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

    before_action :authenticate_user!

    def lab_tests
        @patient = current_user
        @lab_tests = MedicalFile.where(user_id: @patient.id, category: MedicalFile.categories[:lab_test])
    end

    def prescriptions
        @patient = current_user
        @prescriptions = MedicalFile.where(user_id: @patient.id, category: MedicalFile.categories[:prescription])
    end

    def appointments
        @patient = current_user
        @appointments = UserAppointment.where(patient_user_id: @patient.id)
    end

    def reviews
        @patient = current_user
        @user_reviews = UserReview.where(patient_user_id: @patient.id)
        @reviews = @user_reviews.map(&:review)
        @doctors = User.where(role: User.roles[:doctor])
    end

end

