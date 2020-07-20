class Cart < ApplicationRecord
	belongs_to :customer
	belongs_to :product
	validates :product_quantity,presence: true,:numericality => { :greater_than => 0 }

	def sub_total
		cart_product.price*cart.product_quantity
	end
end
