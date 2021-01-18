class Cafe < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :state
  belongs_to :user #optional creator of it

end
