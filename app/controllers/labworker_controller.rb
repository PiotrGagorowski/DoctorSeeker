class LabworkerController < ApplicationController
    def labworker
        @patients = User.where(role: 'patient')
    end
end
