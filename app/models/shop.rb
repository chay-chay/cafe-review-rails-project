class Shop < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :state
  belongs_to :user #optional creator of it (shop added by user)
  
  #validation
  validates :name, presence: true
  validate :shop_unique
  
  # accepts_nested_attributes_for :state 
  def state_attributes=(attributes) #add state in the cafe
    if !attributes[:name].blank? 
        self.name = State.find_or_create_by(attributes)
    end
  end


  def shop_unique
    # if there is already a shop with same state, throw an error
    shop_exits = Shop.find_by(name: name, state_id: state_id)
    if !!shop_exits && shop_exits!= self
      errors.add(:name, 'has already been added for the state')
    end
  end
  

  def self.alphabet
    order(:name)
  end

  def name_state
    "#{name} - #{state.try(:name)}"
  end

  
end
