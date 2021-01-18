class Review < ApplicationRecord
  belongs_to :user
  belongs_to :cafe

  validates :rating, presence: true
  validates :content, presence: true, length: { maximum: 500 }
end
