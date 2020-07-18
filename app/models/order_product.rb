class OrderProduct < ApplicationRecord

	with_options presence: true do
		validates :customer_id
		validates :product_id
		validates :product_quantity
		validates :unit_price
		validates :production_status
	end

	attribute :production_status, :integer, default: 0

	belongs_to :customer
	belongs_to :product



	enum production_status:{
		not_payment:        		0, #着手不可
		waiting_production:         1, #製作待ち
		in_production:   			2, #製作中
		production_completed:  		3, #製作完了
	}
end
