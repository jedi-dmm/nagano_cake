class OrderProduct < ApplicationRecord

	with_options presence: true do
		validates :order_id
		validates :product_id
		validates :product_quantity
		validates :unit_price
		validates :production_status
	end

	attribute :production_status, :integer, default: 0

	belongs_to :order
	belongs_to :product



	enum production_status:{
		着手不可:        	0, #not_payment
		製作待ち:        1, #waiting_production
		製作中:   		2, #in_production
		製作完了:  		3, #production_completed
	}
end
