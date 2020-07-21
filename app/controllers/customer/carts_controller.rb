class Customer::CartsController < ApplicationController
	def index
		@carts = current_customer.carts
	end

	def destroy
		@cart = Cart.find(params[:id])
		@cart.destroy
		redirect_to carts_path
	end

	def update
		@cart = Cart.find(params[:id])
		if @cart.update(cart_params)
			redirect_to carts_path
		else
			render 'carts/index'
		end
	end

	def destroy_all
		@carts = current_customer.carts
		@carts.destroy_all
		redirect_to carts_path
	end


	private
	def cart_params
		params.require(:cart).permit(:product_quantity)
	end
end
