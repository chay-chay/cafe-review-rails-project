class SessionsController < ApplicationController
  def home
  end

  def new
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    #if @user && @user.authenticate(params[:user][:password])
    if @user.try(:authenticate, params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to login_path
  end
end

  def destroy
    session.delete(:user_id) #session.clear
    redirect_to root_path
  end

end
