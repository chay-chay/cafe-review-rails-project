class Shop < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews
  belongs_to :state
  belongs_to :user #optional creator of it

  accepts_nested_attributes_for :state
end
