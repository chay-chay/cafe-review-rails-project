module ApplicationHelper
    def logged_in?
        !!current_user
    end

    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_authorized 
        @shop = Shop.find_by_id(params[:id])
        if @shop.try(:user) != current_user
            
            redirect_to shops_path, danger: "Only user who created can edit or delete the shop!"
        end
    end

    def redirect_if_not_authorized_review
        @review = Review.find_by_id(params[:id])
        if @review.user != current_user
            redirect_to reviews_path, danger: "Only user who created can edit or delete the review!"
        end
    end

end
