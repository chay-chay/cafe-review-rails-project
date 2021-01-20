class State < ApplicationRecord
    has_many :shops
    validates :name, presence: true, uniqueness: {case_sensitive: false}
    scope :search_by_name, -> (search) { where("name LIKE ?", "%#{search}%")}
    

   def self.alpha
    order(:name)
   end

   def state_upcase
    self.upcase
   end

end
