class SessionsController < ApplicationController
  add_flash_types :success, :info, :warning, :danger
  layout "welcome"

  def home
    
  end

  def new
      @user = User.new
     
  end


  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.valid?
        session[:user_id] = user.id
        redirect_to user_path(user)
    else
        redirect_to '/login', danger: user.errors
    end
end

  def create
    @user = User.find_by(username: params[:user][:username])
    #if @user && @user.authenticate(params[:user][:password])
    if @user.try(:authenticate, params[:user][:password]) #if nill, not call authenticate
      session[:user_id] = @user.id
      redirect_to user_path(@user), success: "You have signed in!"
    else
      redirect_to login_path, danger: "Oops! Invalid Username or Password. Please try again."
    end
  end

  def destroy
    session.delete(:user_id) #session.clear
    redirect_to root_path, info: "You have successfully logged out!"
  end


end
