class ApplicationController < ActionController::Base
  include ApplicationHelper  #give us access to the helper methods in that module
  add_flash_types :success, :info, :warning, :danger



  def redirect_if_not_logged_in
    if !logged_in?
      redirect_to '/login' , warning: "login required!"
    end
  end

  
end
