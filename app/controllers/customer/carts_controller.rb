class Customer::CartsController < ApplicationController
	def show
		@cart.customer_id = current_user.id
		@product = Product.find(params[:id])
		@cart.product_id = @product.id
		@carts = current_user.carts
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
			render 'show'
		end
	end

	def destroy_all
		@carts = current_user.carts
		@carts.destrot
		redirect_to carts_path
	end


	private
	def cart_params
		params.require(:cart).permit(:product_quantity)
	end
end
