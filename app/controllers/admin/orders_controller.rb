class Admin::OrdersController < ApplicationController
    # before_action :authenticate_customer!

	def index
		@orders = Order.all.order(created_at: "DESC")
	end

	def show
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
	    if @order.order_status == "入金待ち"
	    	@order.update(order_params)
	    	@order.order_products.each do |order_product|
	    		order_product.production_status = "製作待ち"
	    		order_product.update(order_product_params)
	    	end
	    	redirect_to admin_order_path(@order), notice: "注文ステータスと製作ステータスを更新しました."
	    else
	    	@order.update(order_params)
	    	redirect_to admin_order_path(@order), notice: "注文ステータスを更新しました."
	    end
	end

	private

	def order_params
		params.require(:order).permit(:order_status)
	end

	def order_product_params
		params.permit(:production_status)
	end

end
