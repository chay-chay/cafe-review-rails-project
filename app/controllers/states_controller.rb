class StatesController < ApplicationController
    before_action :redirect_if_not_logged_in
    add_flash_types :success, :info, :warning, :danger
    
    def index
        if params[:name]
            @states = State.search_by_name(params[:name]).alpha
        else
            @states = State.alpha
        end

    
    end

    def show
        @state = State.find_by_id(params[:id])
        @shop = Shop.find_by_id(params[:id])
     
        
    end

end
