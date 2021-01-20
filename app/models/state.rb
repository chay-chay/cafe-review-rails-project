class State < ApplicationRecord
    has_many :shops
    validates :name, uniqueness: true
   
   def self.alpha
    order(:name)
   end

 

end
