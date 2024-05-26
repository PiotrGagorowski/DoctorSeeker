class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :pesel_number])
    end

    private
    def set_time_zone
        Time.zone = current_user.time_zone
    end
end
