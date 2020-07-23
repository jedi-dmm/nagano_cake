class Customer::CartsController < ApplicationController

	def index
		@carts = current_customer.carts
	end

	def create
		@cart = current_customer.carts.new(cart_params)
		@carts = current_customer.carts.all

		# 同じ商品IDがあれば合計する
		@carts.each do |cart|
			if cart.product_id == @cart.product_id
				new_quantity = cart.product_quantity + @cart.product_quantity
				cart.update_attribute(:product_quantity, new_quantity)
				@cart.delete
			else
				@cart.save
			end
		end

		redirect_to carts_path

		# 同じ商品が別にできてしまう
		# @cart = Cart.new(cart_params)
		# @cart.customer_id = current_customer.id
		# @cart.save
		# redirect_to carts_path
	end

	def destroy
		@cart = Cart.find(params[:id])
		@cart.destroy
		redirect_to carts_path
	end

	def update
		@carts = current_customer.carts
		@cart = Cart.find(params[:id])
		if @cart.update(cart_params)
			redirect_to carts_path,notice: "#{@cart.product.name}の数量を変更しました"
		else
			render :index
			flash.now[:alert] = "再度変更をお願いします"
		end
	end

	def destroy_all
		@carts = current_customer.carts
		@carts.destroy_all
		redirect_to carts_path
	end


	private
	def cart_params
		params.require(:cart).permit(:product_id,:customer_id,:product_quantity)
	end
end
