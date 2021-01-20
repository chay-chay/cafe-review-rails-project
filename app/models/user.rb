class User < ApplicationRecord
    has_many :reviews
    #Option1 
    has_many :shops, through: :reviews #review
    #option 2
    #has_many :reviewed_shops, through: :reviews, source: :shop

    #options 3
    #has_many :shops #this are shops that they created
    has_many :created_shops, class_name: "Shop" #creted Use this

    # has_one :shop #optional that they have created
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { in: 6..20 }

    
end
