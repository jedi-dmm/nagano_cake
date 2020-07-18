class Genre < ApplicationRecord
	has_many :products,dependent: :destroy
	validates :name, presence: true, unique: true
end
