class Admin::OrderProductsController < ApplicationController
    # before_action :authenticate_customer!

	def update
		@order_product = OrderProduct.find(params[:id])
	    if @order_product.production_status == "製作待ち" && params[:order_product][:production_status] = "製作中"
	    	@order_products =OrderProduct.where(order_id: @order_product.order_id)
	    	@order_products.each do |order_product|
	    		order_product.production_status = "製作中"
	    		order_product.update(order_product_params)
	    	end
	        redirect_to admin_order_path(@order_product.order), notice: "全ての商品の製作ステータスを更新しました."
	    else
	    	@order_product.update(order_product_params)
	        redirect_to admin_order_path(@order_product.order), notice: "製作ステータスを更新しました."
	    end
	end

	def order_product_params
		params.require(:order_product).permit(:production_status)
	end

end
