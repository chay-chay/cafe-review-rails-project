class Shop < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :state
  belongs_to :user #optional creator of it 
  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
  
  # accepts_nested_attributes_for :state 
  def state_attributes=(attributes) #add state in the cafe
    if !attributes[:name].blank? 
        self.name = State.find_or_create_by(attributes)
    end
end

end
