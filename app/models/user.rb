class User < ApplicationRecord
    has_many :reviews
    has_many :cafes, through: :reviews
    has_one :cafe #optional that they have created
end
