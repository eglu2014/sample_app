class UsersController < ApplicationController
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
      		flash[:success] = "___ Welcome to the Sample App ___ // приложение"
      		redirect_to @user
    	else
      		render 'new'
    	end
  	end
#----------------------------------------------------------------
  	private
    def user_params
      	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
#----------------------------------------------------------------
end
