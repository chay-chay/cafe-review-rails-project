class State < ApplicationRecord
    has_many :shops

    validates :name, presence: true, uniqueness: true
end
