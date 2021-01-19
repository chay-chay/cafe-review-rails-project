class ReviewsController < ApplicationController
    def new
        if @shop = Shop.find_by_id(params[:shop_id]) #nested
            @review = @shop.reviews.build
          else
            @review = Review.new #not nested
          end
        #@review.build_shop
        #review belongs to shop
    end

    def create
        # @review = Review.new(review_params)
        @review = current_user.reviews.build(review_params)
        #@review.user_id = session[:user_id]
        if @review.save  
        redirect_to review_path(@review)
        else
            render :new
        end
    end

    def show
        @review = Review.find_by_id(params[:id])
        @review.shop
      end

    def index
        if @shop = Shop.find_by_id(params[:shop_id])
            #Check for nested like shop/1/reviews ans valid id
            @reviews = @shop.reviews
          else
            #it's not nested routes
            @reviews = Review.all
          end
        
    end

    private

    def review_params
        params.require(:review).permit(:shop_id, :rating, :content )
    end


    

end
