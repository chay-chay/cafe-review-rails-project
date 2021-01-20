class StatesController < ApplicationController
    def index
        if params[:name]
            @states = State.search_by_name(params[:name])
        else
            @states = State.alpha
        end
    end

    def show
        @state = State.find_by_id(params[:id])
    end

end
