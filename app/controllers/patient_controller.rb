class PatientController < ApplicationController
    def patient   
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
    end
end
