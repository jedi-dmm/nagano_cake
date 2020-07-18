class Order < ApplicationRecord

   with_options presence: true do
		validates :customer_id
		validates :payment
		validates :postage
		validates :order_status
		validates :name
		validates :postcode
		validates :address
	end

	attribute :payment, :integer, default: 0
	attribute :order_status, :integer, default: 0

	has_many :order_products, dependent: :destroy
	belongs_to :customer


	enum order_status:{
		waiting_for_payment:        0, #入金待ち
		payment_confirmation:       1, #入金確認
		In_production:   			2, #製作中
		preparing_for_shipping:     3, #発送準備中
		completed_shipping:     	4, #発送済み
	}

	enum payment:{
		credit:           			0, #クレジットカード
		bank:          				1, #銀行振込
	}

end
