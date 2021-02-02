class State < ApplicationRecord
    has_many :shops
    validates :name, presence: true, :uniqueness => {:case_sensitive => false}
    scope :alpha, -> {order(:name)}
    scope :search_by_name, -> (search) { where("name LIKE ?", "%#{search}%")}
    before_save :upcase_fields
    

   def upcase_fields
      self.name.upcase!
   end


end
