class Customer::OrdersController < ApplicationController

	def index
	end

	def new
		@order = Order.new
		# @order_product = Order_product.new
		# @cart = Cart.where(customer_id: current_customer.id)
		# @order.customer_id = current_customer.id
		# @order_product.customer_id = current_customer.id
	end

	def create
	end

	def show
		order = Order.find(params[:id])
		order.order_products.each do |order_product|
			subtotal = order_product.unit_price * order_product.product_quantity
			total_fee = total_fee + subtotal
		end
		charge = order.postage + total_fee
	end

	def confirm
  		@order = Order.new(order_params)
		render :new if @order.invalid?
	end

	def thanks
	end

	private

    def order_params
        params.require(:book).permit(:title, :body)
    end

    def order__product_params
        params.require(:book).permit(:title, :body)
    end

end
