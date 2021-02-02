class UsersController < ApplicationController
    before_action :logged_in?
    layout "welcome"

    def new
        @user = User.new
        
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find_by_id(params[:id])
        redirect_to root_path if !@user
    end

#    def most_user
#     @users = User.most_user
#    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
