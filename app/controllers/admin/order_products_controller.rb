class Admin::OrderProductsController < ApplicationController
    before_action :authenticate_admin!

	def update
		@order_product = OrderProduct.find(params[:id])
	    @order_products =OrderProduct.where(order_id: @order_product.order_id)
	    @order = Order.find(@order_product.order_id)
	    	#
	    if @order.order_status == "入金待ち"
	        redirect_to admin_order_path(@order_product.order), alert: "未入金のため, 製作を開始できません. 先に注文ステータスを更新してください."

	    elsif @order_products.where.not(production_status: "製作待ち").blank?
	    # if @order_products.where(production_status: "製作中").blank? && @order_products.where(production_status: "製作完了").blank?
	    	@order_product.update(order_product_params)
	    	@order.order_status = "製作中"
	    	@order.save(order_params)
	        redirect_to admin_order_path(@order_product.order), notice: "注文ステータスと製作ステータスを更新しました."
	    else
	    	@order_product.update(order_product_params)
	        redirect_to admin_order_path(@order_product.order), notice: "製作ステータスを更新しました."
	    end
	end

	def order_product_params
		params.require(:order_product).permit(:production_status)
	end

	def order_params
		params.permit(:order_status)
	end

end
