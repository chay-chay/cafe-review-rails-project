class StatesController < ApplicationController
    def index
        @states = State.alpha
    end

    def show
        @state = State.find_by_id(params[:id])
    end

end
