class Cart < ApplicationRecord
	belongs_to :customer
	belongs_to :product
	validates :product_quantity,presence: true,:greater_than 0
end
