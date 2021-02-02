class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 6}
  validates :content, presence: true, length: { maximum: 500 }
  validates :user, :uniqueness => {scope: :shop}
  # Ex:- scope :active, -> {where(:active => true)}
  scope :order_by_review, -> { order("rating DESC") }
 
 

  def name_state
   self.shop.state.name
  end

  def avg_rating
    # count = Shop.find_by_id(shop_id)
    self.shop.reviews.average(:rating)
    # Review.average(:rating).round(2)
  end

  def count_reviews
    # count = Shop.find_by_id(shop_id)
    self.shop.reviews.size
    #count(:rating)
  end

  


    


end
