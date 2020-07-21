class Cart < ApplicationRecord
	belongs_to :customer
	belongs_to :product
	validates :product_quantity,presence: true,:numericality => { :greater_than => 0 }
end
