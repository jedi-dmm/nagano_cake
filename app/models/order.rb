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
		入金待ち:        0, #waiting_for_payment
		入金確認:       	1, #payment_confirmation
		製作中:   		2, #In_production
		発送準備中:     	3, #preparing_for_shipping
		発送済み:     	4, #completed_shipping
	}

	enum payment:{
		クレジットカード: 0,
		銀行振込:        1,
	}

end
