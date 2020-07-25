class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!

	def index
		@orders = Order.all.order(created_at: "DESC")
	end

	def show
		@order = Order.find(params[:id])
	end

	def update
		@order = Order.find(params[:id])
			# 入金確認時にすべての商品を制作ステータスを製作待ちに変更
	    if @order.order_status == "入金待ち" && params[:order][:order_status] == "入金確認"
	    	@order.update(order_params)
	    	@order.order_products.each do |order_product|
	    		order_product.production_status = "製作待ち"
	    		order_product.update(order_product_params)
	    	end
	    	redirect_to admin_order_path(@order), notice: "注文ステータスと製作ステータスを更新しました."
	    	# 未制作の商品があるか確認し、なければ注文ステータスを更新。
	    elsif @order.order_status == "製作中" && params[:order][:order_status] == "発送準備中"
	    	if @order.order_products.where.not(production_status: "製作完了").exists?
	    		redirect_to admin_order_path(@order), notice: "未製作の商品があります. 製作を完了してください."
	    	else
	    		@order.update(order_params)
	    		redirect_to admin_order_path(@order), notice: "注文ステータスを更新しました."
	    	end
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
