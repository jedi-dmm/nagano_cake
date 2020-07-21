class Customer::OrdersController < ApplicationController

	def index
	end

	def new
		@posts = Post.where(customer_id: current_customer.id)
		@order = Order.new
		# @cart = Cart.where(customer_id: current_customer.id)
		# @order.customer_id = current_customer.id
		# @order_product.customer_id = current_customer.id
	end

	def confirm
		@order = Order.new(order_params)
		@order.customer_id = current_customer.id
		@order.postage = Constants::POSTAGE
		@post = Post.find_by(id: @order.address)
		@order.postcode = @post.postcode
		@order.address = @post.address
		@order.name = @post.name
		render :new if @order.invalid?
	end

	def create
		# order_product = Order_product.new
		@order = Order.new(order_params)
		@order.customer_id = current_customer.id
	    if @order.save
	    	redirect_to thanks_path
	 	else
	    	redirect_to new_order_path
	    end
	end

	def show
	end

	def thanks
	end

	private

	def order_params
		params.require(:order).permit(:customer_id, :payment, :postage, :name, :postcode, :address)
	end

	def order_product_params
		params.require(:order_product).permit(:payment, :postage, :name, :postcode, :address)
	end

end
