class MedicalFilesController < ApplicationController
  before_action :set_medical_file, only: %i[ show edit update destroy ]

  # GET /medical_files or /medical_files.json
  def index
    @medical_files = MedicalFile.all
  end

  # GET /medical_files/1 or /medical_files/1.json
  def show
  end

  # GET /medical_files/new
  def new
    @medical_file = MedicalFile.new
  end

  # GET /medical_files/1/edit
  def edit
  end

  # POST /medical_files or /medical_files.json
  def create
    @medical_file = MedicalFile.new(medical_file_params)

    respond_to do |format|
      if @medical_file.save
        @medical_file.file.attach(params[:medical_file][:file])
        #format.html { redirect_to medical_file_url(@medical_file), notice: "Medical file was successfully created." }
        #format.json { render :show, status: :created, location: @medical_file }
       
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medical_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medical_files/1 or /medical_files/1.json
  def update
    respond_to do |format|
      if @medical_file.update(medical_file_params)
        format.html { redirect_to medical_file_url(@medical_file), notice: "Medical file was successfully updated." }
        format.json { render :show, status: :ok, location: @medical_file }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @medical_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_files/1 or /medical_files/1.json
  def destroy
    @medical_file.destroy!

    respond_to do |format|
      format.html { redirect_to medical_files_url, notice: "Medical file was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medical_file
      @medical_file = MedicalFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def medical_file_params
      params.require(:medical_file).permit(:category, :user_id, :file)
    end
end
