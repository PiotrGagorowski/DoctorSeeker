class PatientController < ApplicationController

    def patient
        @appointments = Appointment.all
        @free_appointments = Appointment.free.where('start_time > ?', DateTime.now)
        @doctors_with_free_appointments = @free_appointments.map(&:doctor).uniq.sort_by { |doctor| [doctor.last_name, doctor.first_name] }

      @user_appointment = UserAppointment.new
  
      # Separate reserved and free appointments
      @reserved_appointments = Appointment.reserved.includes(:user_appointments)
      @free_appointments_calendar = Appointment.free
  
    end
  
    def user_appointment_params
      params.require(:user_appointment).permit(:patient_user_id, :appointment_id)
    end

    before_action :authenticate_user!
    
    def lab_results
        @patient = current_user
        @lab_results = MedicalFile.where(user_id: @patient.id, category: MedicalFile.categories[:lab_results])
        @comments = Comment.where(file_id: @lab_results.pluck(:id))
      end

      def comment
        @patient = current_user
        @doctor = User.where(role: 'doctor')
        @lab_results = MedicalFile.where(user_id: @patient.id, category: MedicalFile.categories[:lab_results])
        medical_file_id = @lab_results.pluck(:id) 
        doctor_id = @lab_results.pluck(:additional_user_id)
        @comment = Comment.where(doctor_user_id: @doctor.id)
      end

    def prescriptions
        @patient = current_user
        @prescriptions = MedicalFile.where(user_id: @patient.id, category: MedicalFile.categories[:prescription])
    end

    def appointments
        @patient = current_user
        @user_appointments = UserAppointment.joins(:appointment)
        .where(patient_user_id: @patient.id)
        .order('appointments.start_time DESC')
        @appointments = UserAppointment.where(patient_user_id: @patient.id).map(&:appointment)
    end

    def reviews
        @patient = current_user
        @user_reviews = UserReview.where(patient_user_id: @patient.id)
        @reviews = @user_reviews.map(&:review)
        @doctors = User.joins(appointments_as_doctor: :user_appointments)
                 .where(user_appointments: { patient_user_id: @patient.id })
                 .where('appointments.start_time < ?', DateTime.now)
                 .distinct
        @user_review = UserReview.new
        @user_review.build_review
    end

    def doctor_appointments
        @doctor = User.find(params[:doctor_id])
        @doctor_free_appointments = @doctor.appointments_as_doctor.free.order(start_time: :asc)
    end

 
end
