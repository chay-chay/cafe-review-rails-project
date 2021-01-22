class ApplicationController < ActionController::Base
 #give us access to the helper methods in that module
 helper_method :current_user, :logged_in?

 def logged_in?
  !!current_user #current_user != nil
end

def current_user
  @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
end



private

  def redirect_if_not_logged_in
      redirect_to '/login' if !logged_in?
  end

end
