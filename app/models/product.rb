class Product < ApplicationRecord
	belongs_to :genre

	enum sale_status:{
		 販売中:   true,
		 売り切れ:  false
		}

	has_many :order_products, dependent: :destroy
	has_many :carts, dependent: :destroy

	attachment :image

    validates :genre_id, presence: true
	validates :name, presence: true, uniqueness: true
	validates :caption, presence: true
	validates :image, presence: true
	validates :price, numericality: true
	validates :sale_status, presence:true
end