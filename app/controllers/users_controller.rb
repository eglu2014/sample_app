class UsersController < ApplicationController

    before_action :signed_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy

    # INDEX (___ 9.23 ___)
    def index
       @users = User.paginate(page: params[:page])
    end
  #----------------------------------------------------------------  
    def show
      @user = User.find(params[:id])
    end
  #----------------------------------------------------------------
  # (Action) действие New
    def new
      @user = User.new
    end
  #----------------------------------------------------------------
	 def create
      @user = User.new(user_params)
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
      else
        render 'new'
      end
    end
  #................................................................
  # -------------EDIT ACTION -------------------: 
    def edit
      @user = User.find(params[:id])
    end
  #................................................................
  # ------------- UPDATE -----------------------
    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    end
  #...............................................
  # _____ 9.44 ______
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  #----------------------------------------------------------------
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # _____9.18 ______ Before filters
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #9.46
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
#----------------------------------------------------------------
end
