class DoctorController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:file]
    before_action :authenticate_user!
    def doctor
    end

    def appointments
        @appointments = current_user.appointments_as_doctor.where(doctor_user_id: current_user.id)
    end
    
    def appointments_json
        @appointments = current_user.appointments_as_doctor.all
        render json: @appointments.to_json
    end

    def create
        puts "Params: #{params.inspect}" # Dodaj to dla debugowania
        @appointment = Appointment.new(appointment_params)

        respond_to do |format|
        if @appointment.save
            format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully created." }
            format.json { render :show, status: :created, location: @appointment }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
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
    def update
        respond_to do |format|
        if @appointment.update(appointment_params)
            format.html { redirect_to appointment_url(@appointment), notice: "Appointment was successfully updated." }
            format.json { render :show, status: :ok, location: @appointment }
        else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @appointment.errors, status: :unprocessable_entity }
        end
        end
    end  

    private
    
    def appointment_params
    params.permit(:appointment_date)
    end
end
