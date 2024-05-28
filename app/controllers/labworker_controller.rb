class LabworkerController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    before_action :authenticate_labworker!
        
    def labworker
        @patients = User.where(role: 'patient')
    
        unless current_user.labworker?             
          flash[:error] = 'Brak dostępu!'             
          redirect_to root_path           
        end    
        @medical_file = MedicalFile.new
    end

    def create
      @medical_file = MedicalFile.new(medical_file_params)
      if @medical_file.save
        redirect_to patients_path, notice: 'Wynik badań został dodany pomyślnie.'
      else
        flash[:error] = 'Wystąpił problem podczas dodawania wyniku badań.'
        redirect_to labworker_path
      end
    end

    def authenticate_labworker!
      redirect_to root_path, alert: 'Brak dostępu!' unless current_user && current_user.labworker?
    end
    
    def patient
      @patients = User.where(role: 'patient')
      @lab_results = MedicalFile.where(user_id:  user.id, category: MedicalFile.categories[:lab_results]) 
    end
    
    def lab_result
      @lab_results = MedicalFile.where(user_id:  @patients.id, category: MedicalFile.categories[:lab_results])
      @medical_file = MedicalFile.new
    end

    def exeresearch
      @patients = User.where(role: 'patient')
      @medical_file = MedicalFile.new
    end
    def patients
      @patients = User.where(role: 'patient')
      @lab_result = MedicalFile.where(category: 'lab_results', user_id: @patients.pluck(:id)).group_by(&:user_id)
    end

    private
     

    def medical_file_params
      params.require(:medical_file).permit(:file, :category, :utility_date, :user_id)
    end
    
end
