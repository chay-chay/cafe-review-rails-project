class Shop < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :state
  belongs_to :user #optional creator of it (shop added by user)
  has_one_attached :image
    #validation
  validates :name, presence: true
  validate :shop_unique
  validates :name, :uniqueness => {scope: :state_id, :case_sensitive => false}
  before_save :upcase_fields
  #scope
  scope :alpha, -> {order(:name)}
  scope :most_reviewed, -> { left_joins(:reviews).group("shops.id").order("count(rating) DESC")}
  scope :cafe_average_rating, -> { left_joins(:reviews).group("shops.id").order("avg(reviews.rating) DESC")}
  
  scope :search_by_name, -> (search) { where("name LIKE ?", "%#{search}%")} #search cafe name
  # scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(rating) desc')} - left join to keep alll data
  # Ex:- scope :active, -> {where(:active => true)}}
  #where("LOWER(name) LIKE LOWER(?)", "%#{query}%")


  # def self.trendy_shop
  #   review = Review.last
  #   review.shop
  # end
  
# Ex:- scope :active, -> {where(:active => true)}
 
  # accepts_nested_attributes_for :state 
  def state_attributes=(attributes) #add state in the cafe 
    if !attributes[:name].blank? 
        self.state = State.find_or_create_by(name: attributes[:name].upcase)
        #attributes is a hash of key value pairs
         #attributes = {"name"=>"COCO cafe")
        #find or create a state based on the attributes sent in
    end
  end

   #custom reader/writer methods 
  def shop_unique
    # if there is already a shop with same state, throw an error
    shop_exits = Shop.find_by(name: name, state_id: state_id)
    if !!shop_exits && shop_exits!= self
      errors.add(:name, 'has already been added for the state')
    end
  end

  def name_state
    "#{name} - #{state.try(:name)}"
  end

  def upcase_fields
    self.name.upcase!
 end

  def avg_rating
    # count = Shop.find_by_id(shop_id)
    self.reviews.average(:rating)
    # Review.average(:rating).round(2)
  end
 
  def count_reviews
    # count = Shop.find_by_id(shop_id)
    self.reviews.size
    #count(:rating)
  end
  
end
