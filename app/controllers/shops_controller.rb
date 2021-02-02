class ShopsController < ApplicationController
    add_flash_types :success, :info, :warning, :danger
    before_action :redirect_if_not_logged_in
    before_action :redirect_if_not_authorized, only: [:edit, :update, :destroy]
    before_action :set_shop, except: [:new, :create]
    
    def index
        if params[:name]
            @shops = Shop.search_by_name(params[:name]).alpha
        elsif params[:filter] && params[:filter] == "most_reviewed"
            @shops = Shop.most_reviewed
        elsif params[:filter] && params[:filter] == "cafe_average_rating"
            @shops = Shop.cafe_average_rating
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

            redirect_to shop_reviews_path(@shop), success: "Thank you for adding a cafe."
        else
            @shop.build_state
            render :new
        end
    end

    def show
      
    end

    def edit 

    end

    def update
        @shop.update(shop_params)
        if @shop.valid?
            @shop.image.purge
            @shop.image.attach(params[:shop][:image])

            redirect_to shop_reviews_path(@shop), success: "Update successful!"
        else
            render :edit 
        end
    end

    def destroy
        @shop.destroy
        redirect_to shops_path, danger: "Your cafe has been delete."
    end

    

    private

    def shop_params
        params.require(:shop).permit(:name, :rating, :state_id, state_attributes:[:name])
    end

    def set_shop
        @shop = Shop.find_by_id(params[:id])
        
     end

     
end
