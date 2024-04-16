class AdminController < ApplicationController
    def admin
      @users = User.all
    end
  
    def new_user
      @user = User.new
    end
  
    def create_user
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_path, notice: 'Użytkownik został dodany.'
      else
        render :new_user
      end
    end
  
    def edit_user
      @user = User.find(params[:id])
    end
  
    def update_user
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_path, notice: 'Uprawnienia użytkownika zostały zaktualizowane.'
      else
        render :edit_user
      end
    end
  
    def destroy_user
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_path, notice: 'Użytkownik został usunięty.'
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
