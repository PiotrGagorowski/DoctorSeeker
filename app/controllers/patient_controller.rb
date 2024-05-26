class PatientController < ApplicationController
  before_action :authenticate_user!

  def patient
    @appointments = Appointment.all
    @user_appointment = UserAppointment.new
    @reserved_appointments = Appointment.reserved.includes(:user_appointments)
    @free_appointments = Appointment.free.where('appointment_date > ?', DateTime.now)
    @doctors_with_free_appointments = @free_appointments.map(&:doctor).uniq.sort_by { |doctor| [doctor.last_name, doctor.first_name] }
  end

  def user_appointment_params
    params.require(:user_appointment).permit(:patient_user_id, :appointments_id)
  end

  def lab_results
    @patient = current_user
    @lab_results = MedicalFile.where(user_id: @patient.id, category: MedicalFile.categories[:lab_results])
  end

  def prescriptions
    @patient = current_user
    @prescriptions = MedicalFile.where(user_id: @patient.id, category: MedicalFile.categories[:prescription])
  end

  def appointments
    @patient = current_user
    @user_appointments = UserAppointment.joins(:appointment)
      .where(patient_user_id: @patient.id)
      .order('appointments.appointment_date DESC')
    @appointments = UserAppointment.where(patient_user_id: @patient.id).map(&:appointment)
  end

  def reviews
    @patient = current_user
    @user_reviews = UserReview.where(patient_user_id: @patient.id)
    @reviews = @user_reviews.map(&:review)
    @doctors = User.joins(appointments_as_doctor: :user_appointments)
                   .where(user_appointments: { patient_user_id: @patient.id })
                   .where('appointments.appointment_date < ?', DateTime.now)
                   .distinct
    @user_review = UserReview.new
    @user_review.build_review
  end

  def doctor_appointments
    @doctor = User.find(params[:doctor_id])
    @doctor_free_appointments = @doctor.appointments_as_doctor.free.order(appointment_date: :asc)
  end
end
