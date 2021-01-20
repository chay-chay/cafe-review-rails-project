class State < ApplicationRecord
    has_many :shops
    validates :name, uniqueness: true
    scope :search_by_name, -> (search) { where("name LIKE ?", "%#{search}%")}
   
   def self.alpha
    order(:name)
   end

 

end
