class DoctorController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:file]
  before_action :authenticate_user!

  def doctor_doctors
    @doctors = User.where(role: :doctor)
  end

  def doctor
    @appointments = current_user.appointments_as_doctor
                                .joins(:user_appointments)
                                .order('appointments.start_time ASC')
                                
    @days = Appointment.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    )
    
    # Pobieramy pacjentów powiązanych z wizytami
    @patients = @appointments.map { |appointment| appointment.user_appointments.map(&:patient) }.flatten.uniq
    
    @users = User.all
  end

  def prescription
      @appointments = Appointment.joins(user_appointments: :patient)
                              .where(doctor_user_id: current_user.id)
                              .order('appointments.start_time ASC')
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
    # Pobierz wszystkie wizyty zalogowanego lekarza, w tym te bez przypisanych pacjentów
    @appointments = current_user.appointments_as_doctor
                     .left_joins(:user_appointments)
                     .distinct
                     .order('appointments.start_time ASC')
  
    # Pobierz wszystkich unikalnych pacjentów powiązanych z tymi wizytami
    @patients = @appointments.flat_map { |appointment| appointment.user_appointments.map(&:patient) }.uniq
  
    # Pobierz wszystkie wizyty w aktualnym miesiącu wraz z pacjentami
    @days = Appointment.where(
      start_time: Time.now.beginning_of_month.beginning_of_week..Time.now.end_of_month.end_of_week
    )
  
    # Pobierz wszystkich użytkowników (jeśli to potrzebne, np. dla jakiegoś dropdown menu)
    @users = User.all
  end
  
  
  def appointments_json
      @appointments = current_user.appointments_as_doctor.all
      render json: @appointments.to_json
  end

  def patients
    @patients = User.joins(:medical_files).where(medical_files: { category: 'lab_results' }).distinct
    @lab_result = MedicalFile.where(category: 'lab_results', user_id: @patients.pluck(:id)).group_by(&:user_id)
  end

  def lab_results
    @appointments = Appointment.joins(user_appointments: :patient)
                               .where(doctor_user_id: current_user.id)
                               .order('appointments.start_time ASC')
                               .distinct
                               .to_a

    @patients = @appointments.map { |appointment| appointment.user_appointments.first.patient }.compact

    @lab_results = MedicalFile.where(user_id: @patients.pluck(:id), category: MedicalFile.categories[:lab_results])
    @comments = Comment.where(file_id: @lab_results.pluck(:id))
  end

  def comment
    @appointments = Appointment.joins(user_appointments: :patient)
                               .where(doctor_user_id: current_user.id)
                               .order('appointments.start_time ASC')
                               .distinct
                               .to_a
                               
    @patients = @appointments.map { |appointment| appointment.user_appointments.first.patient }
  
    @lab_results = MedicalFile.where(user_id: @patients.map(&:id), category: MedicalFile.categories[:lab_results])
    lab_result_ids = @lab_results.pluck(:id)
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to lab_results_path, notice: 'Komentarz dodany pomyślnie.'
    else
      redirect_to lab_results_path, alert: 'Nie udało się dodać komentarza.'
    end
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
  params.permit(:start_time, :end_time)
  end
  def medical_file_params
      params.require(:medical_file).permit(:file, :category, :utility_date, :user_id)
  end

  def comment_params
    params.require(:comment).permit(:doctor_user_id, :file_id, :comment)
  end

    
end

