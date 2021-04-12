class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
    has_many :reviews
    #Option1 
    has_many :shops, through: :reviews #review
    #option 2
    #has_many :reviewed_shops, through: :reviews, source: :shop

    #options 3
    #has_many :shops #this are shops that they created
    # has_many :created_shops, class_name: "Shop" #Jenn recommened this one for creted use this code.

    # has_one :shop #optional that they have created
    has_secure_password
    # validate the presence of password
    # gives us these methods:  .password=, .authenticate, .password
    # validates :username, presence: true, on: :update 

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    # validates :password, presence: true, length: { in: 6..20 }, on: :create
    
    def self.from_omniauth(response)
        User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
            u.username = response[:info][:email]
            u.email = response[:info][:email]
            u.password = SecureRandom.hex(15)
        end
    end








    #scope :most_user, -> { joins(:reviews).group("users.id").order("count(content) DESC")}
    
  
end
