module ReviewsHelper
    def show_add_review
        if @reviews.blank? 
            content_tag(:h1, "No reviews just yet, would you like to add the first?")
            link_to "Write a review", new_shop_review_path, class: "btn"
        end
    end
end
