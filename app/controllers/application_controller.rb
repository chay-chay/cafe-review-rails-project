class ApplicationController < ActionController::Base
  include ApplicationHelper  #give us access to the helper methods in that module


private

  def redirect_if_not_logged_in
      redirect_to '/login' if !logged_in?
  end


end
