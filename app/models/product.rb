class Product < ApplicationRecord
	belongs_to :genre

	has_many :order_products, dependent: :destroy
	has_many :carts, dependent: :destroy

    validates :genre_id, presence: true
	validates :name, presence: true, uniqueness: true
	validates :caption, presence: true
	validates :image_id, presence: true
	validates :price, numericality: true
	validates :sale_status, inclusion: { in: [true, false] }
end