class State < ApplicationRecord
    has_many :shops

   validates :name, uniqueness: true 
   
   def self.alphabet
    order(:name)
   end

end
