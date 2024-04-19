class DoctorController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:file]
    before_action :authenticate_user!

    def doctor_doctors
      @doctors = User.where(role: :doctor)
    end

    def doctor
        @appointments = current_user.appointments_as_doctor
                                .joins(:user_appointments)
                                .where('user_appointments.appointment_id = appointments.id')
                                .order('appointments.appointment_date ASC')
        @patients = @appointments.map { |appointment| appointment.user_appointments.first.patient }
    end
    def prescription
        @appointments = Appointment.joins(user_appointments: :patient)
                                .where(doctor_user_id: current_user.id)
                                .order('appointments.appointment_date ASC')
                                .distinct
                                .to_a
                                
        @patients = @appointments.map { |appointment| appointment.user_appointments.first.patient }

        @patients_without_prescription = @appointments.map do |appointment|
            appointment.user_appointments.first.patient unless appointment.user_appointments.first.patient.medical_files.where(category: :prescription).exists?
          end.compact.uniq
          

          @patients_with_prescription = User.where(
            id: MedicalFile.where(category: MedicalFile.categories[:prescription]).select(:user_id)
          ).distinct

        @medical_file = MedicalFile.new
    end

       
      
    def appointments
        @appointments = current_user.appointments_as_doctor.where(doctor_user_id: current_user.id)
    end
    
    def appointments_json
        @appointments = current_user.appointments_as_doctor.all
        render json: @appointments.to_json
    end


    def file
        path = Rails.root.join('app', 'javascript', params[:filename])
        if File.exist?(path)
          send_file path, disposition: 'inline', type: 'application/javascript'
        else
          render plain: 'Not Found', status: 404
        end
      end
      # PATCH/PUT /appointments/1 or /appointments/1.json

    private
    
    def appointment_params
    params.permit(:appointment_date)
    end
    def medical_file_params
        params.require(:medical_file).permit(:file, :category, :utility_date, :user_id)
      end
      
end

