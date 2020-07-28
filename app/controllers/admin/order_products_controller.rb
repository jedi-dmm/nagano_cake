class Admin::OrderProductsController < ApplicationController
    before_action :authenticate_admin!

	def update
		@order_product = OrderProduct.find(params[:id])
	    @order_products =OrderProduct.where(order_id: @order_product.order_id)
	    @order = Order.find(@order_product.order_id)
	    	# 未入金の場合は製作ステータスを変更させない
	    if @order.order_status == "入金待ち"
	        redirect_to admin_order_path(@order_product.order), alert: "未入金のため, 製作を開始できません. 先に注文ステータスを更新してください."

	    	# 一つでも製作待ちから製作中or制作完了に変更された場合、注文ステータスを製作中に変更する
	    elsif @order_products.where.not(production_status: "製作待ち").blank?
	    	@order_product.update(order_product_params)
	    	@order.order_status = "製作中"
	    	@order.save(order_params)
	        redirect_to admin_order_path(@order_product.order), notice: "製作ステータスを更新しました. また製作開始を確認したため, 注文ステータスを製作中に更新しました."

	    	# 全て製作ステータスが制作完了の状態から一つでも製作中に変更された場合、注文ステータスを製作中に戻す
	    elsif @order_products.where.not(production_status: "製作完了").blank? && params[:order_product][:production_status] == "製作中"
	    	@order_product.update(order_product_params)
	    	@order.order_status = "製作中"
	    	@order.save(order_params)
	        redirect_to admin_order_path(@order_product.order), notice: "製作ステータスが製作中に戻されたため、注文ステータスを製作中に変更しました."

	    	#全ての制作ステータスが制作完了に更新された際、注文ステータスを発送準備中に更新
	    else
	    	@order_product.update(order_product_params)
	    	if @order_products.where.not(production_status: "製作完了").blank?
		    	@order.order_status = "発送準備中"
		    	@order.save(order_params)
		        redirect_to admin_order_path(@order_product.order), notice: "注文ステータスと製作ステータスを更新しました."
		    else
	        	redirect_to admin_order_path(@order_product.order), notice: "製作ステータスを更新しました."
	       	end
	    end
	end

	def order_product_params
		params.require(:order_product).permit(:production_status)
	end

	def order_params
		params.permit(:order_status)
	end

end
