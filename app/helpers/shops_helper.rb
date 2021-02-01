module ShopsHelper
    def user_access
        current_user == @shop.user 
    end

  
   
end
