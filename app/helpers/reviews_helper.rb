module ReviewsHelper
    def show_add_review
        if @reviews.blank? 
            content_tag(:h1, "No reviews just yet, would you like to add the first?")
            link_to "Write a review", new_shop_review_path, class: "btn"
        end
    end

    def user_authorized_for_review
        @review.user == current_user
    end
    
    def review_rating
        @review.rating.to_i
    end
   

    # def rating_star
    #     rating = Review.average(:rating).round(2)
    # end
end
