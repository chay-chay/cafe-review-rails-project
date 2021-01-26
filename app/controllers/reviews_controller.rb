class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_authorized_review, only: [:edit, :update, :destroy]
  add_flash_types :success, :info, :warning, :danger
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
          redirect_to review_path(@review), success: "Thank you for your review submission."
        else
            render :new
        end
    end

    def show
        @review = Review.find_by_id(params[:id])
        @shop = @review.shop
      end

      def edit 
        @review = Review.find_by_id(params[:id])
       
    end

    def update
        @review = Review.find(params[:id])
        
        @review.update(review_params)
        if @review.valid?
            redirect_to review_path, success: "Update successful!"
        else
            render :edit 
        end
    end

    def index
   
        if @shop = Shop.find_by_id(params[:shop_id])
            #Check for nested like shop/1/reviews and valid id
            @reviews = @shop.reviews
          else
            #it's not nested routes
            @reviews = Review.all
          end
          # @shop = Shop.find_by_id(params[:shop_id])
          # @shop_review = @shop.reviews
    end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      redirect_to shop_path, danger: "Your review has been delete."
  end

    private

    def review_params
        params.require(:review).permit(:shop_id, :rating, :content )
    end
    

end
