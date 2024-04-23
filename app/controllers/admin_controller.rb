class AdminController < ApplicationController
    before_action :authenticate_admin!


    def admin
        unless current_user.admin?
            flash[:error] = 'Brak dostępu!'
            redirect_to root_path
          end
          @users = User.all
    end

    def users_list
      unless current_user.admin?
          flash[:error] = 'Brak dostępu!'
          redirect_to root_path
        end
        @users = User.all
    end


    def admin_doctors
      @doctors = User.where(role: :doctor)
    end
    

    def new_user
      @user = User.new
    end
  
    def create_user
        @user = User.new(user_params)
        if @user.save
          flash[:success] = 'Użytkownik został dodany.'
          redirect_to admin_path
        else
          flash[:error] = 'Wystąpił błąd podczas dodawania użytkownika.'
          render :new_user
        end
      end
  
    def edit_user
      @user = User.find(params[:id])
    end
  
    def update_user
        @user = User.find(params[:id])
        if @user.update(user_params)
          flash[:success] = 'Uprawnienia użytkownika zostały zaktualizowane.'
          redirect_to admin_path
        else
          flash[:error] = 'Wystąpił błąd podczas aktualizacji użytkownika.'
          render :edit_user
        end
      end
  
    def destroy_user
        @user = User.find(params[:id])
        if @user.destroy
          flash[:success] = 'Użytkownik został usunięty.'
        else
          flash[:error] = 'Wystąpił błąd podczas usuwania użytkownika.'
        end
        redirect_to admin_path
      end


    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :pesel_number, :role)
    end

    def set_user
        @user = User.find(params[:id])
      end
    
      def authenticate_admin!
        redirect_to root_path, alert: 'Brak dostępu!' unless current_user && current_user.admin?
      end

  end
