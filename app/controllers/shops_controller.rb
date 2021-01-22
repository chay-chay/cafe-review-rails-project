class ShopsController < ApplicationController
    add_flash_types :success, :info, :warning, :danger
    before_action :redirect_if_not_logged_in
    before_action :redirect_if_not_authorized, only: [:edit, :update, :destroy]

    def index
        
        @shop =  Shop.find_by_id(params[:id])
        if params[:name]
            @shops = Shop.search_by_name(params[:name])
        else
            @shops = Shop.alpha
        end
    end
    
    def new
        @shop = Shop.new
        @shop.build_state
    end

    def create
        @shop = Shop.new(shop_params)
        @shop.user_id = session[:user_id]
       
        if @shop.save
            @shop.image.purge
            @shop.image.attach(params[:shop][:image])

            redirect_to shop_path(@shop), success: "Thank you for adding a cafe."
        else
            @shop.build_state
            render :new
        end
    end

    def show
        @shop = Shop.find_by_id(params[:id])
    end

    def edit 
        
        @shop = Shop.find_by_id(params[:id])
       
    end

    def update
        
        @shop = Shop.find(params[:id])
        @shop.update(shop_params)
        if @shop.valid?
            @shop.image.purge
            @shop.image.attach(params[:shop][:image])

            redirect_to shops_path, success: "Update successful!"
        else
            render :edit 
        end
    end

    def destroy
        @shop = Shop.find(params[:id])
        @shop.destroy
        redirect_to shops_path 
    end



    private

    def shop_params
        params.require(:shop).permit(:name, :rating, :state_id, state_attributes:[:name])
    end

    def set_shop
        @shop = Shop.find_by_id(params[:id])
        redirect_to shops_path if !@shop
     end

     def redirect_if_not_authorized #make these methods easier to change & DRY.
        @shop = Shop.find_by_id(params[:id])
        if @shop.user != current_user
            
            redirect_to shops_path, danger: "Only user who created can delete the shop!"
        end
    end
end
