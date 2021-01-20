class SessionsController < ApplicationController
  def home
  end

  def new
  end

  # def omniauth #if they are logging in with oauth
  #   if that user has already logged in this way
  #   user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |u|
  #       u.email = auth["info"]["email"]
  #       u.password = SecureRandom.hex(15)
  #       u.username = auth["info"]["email"]
  #   end


  def omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.valid?
        session[:user_id] = user.id
        redirect_to user_path(user)
    else
        redirect_to '/login'
    end
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
