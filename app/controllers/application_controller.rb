class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :pesel_number])
    end


    def after_sign_in_path_for(resource)
        case resource.role
        when 'doctor'
          doctor_path
        when 'patient'
          patient_path
        when 'labworker'
          labworker_path
        when 'admin'
          admin_path
        else
          root_path
        end
      end
end
