class User < ApplicationRecord
    has_many :reviews
    has_many :cafes, through: :reviews
    has_one :cafe #optional that they have created
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { in: 6..20 }
end
