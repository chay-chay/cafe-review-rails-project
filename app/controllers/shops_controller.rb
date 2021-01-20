class ShopsController < ApplicationController
    
    def index
        @shops = Shop.all
    end
    
    def new
        @shop = Shop.new
        @shop.build_state
    end

    def create
        @shop = Shop.new(shop_params)
        @shop.user_id = session[:user_id]
        if @shop.save
            redirect_to shop_path(@shop)
        else
            @shop.build_state
            render :new
        end
    end

    def show
        @shop = Shop.find_by_id(params[:id])
    end


    private

    def shop_params
        params.require(:shop).permit(:name, :rating, :state_id, :user_id, state_attributes:[:name])
    end
end
