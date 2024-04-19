# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def after_sign_in_path_for(resource)
    if current_user.patient?
      patient_path
    elsif current_user.admin?
      admin_path
    elsif current_user.doctor?
      doctor_path
    elsif current_user.labworker?
      labworker_path
    else
      root_path
    end 
  end   
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def appointments
    Appointment.joins(:user_appointments_as_patient).where(user_appointments_as_patient: { patient_user_id: self.id })
  end
  
end
