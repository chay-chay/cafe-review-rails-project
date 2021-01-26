class Shop < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :state
  belongs_to :user #optional creator of it (shop added by user)
  has_one_attached :image
  validates :name, :uniqueness => {scope: :state_id, :case_sensitive => false}
 
  # Ex:- scope :active, -> {where(:active => true)}}
  #where("LOWER(name) LIKE LOWER(?)", "%#{query}%")
  scope :search_by_name, -> (search) { where("name LIKE ?", "%#{search}%")} #search cafe name
  
  # scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(rating) desc')}
  #validation
  validates :name, presence: true
  # validate :shop_unique
  before_save :upcase_fields
  scope :alpha, -> {order(:name)}
  
  
 
  # accepts_nested_attributes_for :state 
  def state_attributes=(attributes) #add state in the cafe 
    if !attributes[:name].blank? 
        self.state = State.find_or_create_by(name: attributes[:name].upcase)#attributes is a hash of key value pairs
    end
  end

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

  def self.sum_rating
    Review.average(:rating)
  end
 
  
end
