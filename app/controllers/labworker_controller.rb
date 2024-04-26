class LabworkerController < ApplicationController
    before_action :authenticate_user!
    
    def labworker
        @patients = User.where(role: 'patient')
    end
end
