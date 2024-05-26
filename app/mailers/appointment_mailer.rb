class AppointmentMailer < ApplicationMailer
    default from: 'no-reply@example.com'
  
    def appointment_deleted
      @appointment = params[:appointment]
      @doctor = @appointment.doctor
      @patients = @appointment.patients
      @patients.each do |patient|
        mail(to: patient.email, subject: "Twoja wizyta została odwołana")
      end
    end
  end