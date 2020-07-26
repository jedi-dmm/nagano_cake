class Customer::OrdersController < ApplicationController
	before_action :authenticate_customer!
	before_action :ensure_correct_customer, only: [:show]
	before_action :ensure_carts_exist, only: [:new ,:confirm]

	def index
		@orders = Order.where(customer_id: current_customer.id).order(created_at: "DESC")
	end

	def new
		@posts = Post.where(customer_id: current_customer.id)
		@order = Order.new
	end

	def confirm
		@order = Order.new
		@order.payment = params[:payment]
		@order.postage = Constants::POSTAGE
		@order.customer_id = current_customer.id
		if params.has_key?(:post_id)					# 住所の選択により、orderに保存する値の参照先が異なるため、条件分岐
			@post = Post.find(params[:post_id][:id])	# 登録している住所が選択された場合
			@order.postcode = @post.postcode
			@order.address = @post.address
			@order.name = @post.name
		elsif params.has_key?(:new_postcode)			# 新しい住所が入力された場合
			@order.postcode = params[:new_postcode]
			@order.address = params[:new_address]
			@order.name = params[:new_name]
		else											# ログインしているカスタマーの住所が選択された場合
			@order.postcode = current_customer.postcode
			@order.address = current_customer.address
			@order.name = current_customer.last_name + current_customer.first_name
	    end
	end

	def create
		@order = Order.new(order_params)
	    if @order.save
	    	current_customer.carts.each do |cart|	    					# カート内容をorder_productとして保存
	    		order_product = OrderProduct.new(order_product_params)
	    		order_product.order_id = @order.id
	    		order_product.product_id = cart.product_id
	    		order_product.unit_price = (cart.product.price * Constants::TAX_RATE).round
	    		order_product.product_quantity = cart.product_quantity
	    		order_product.save
	    	end

	    	customer_posts = Post.where(address: @order.address)	    	# 住所が新規であった場合、postに新規保存する
	    	if current_customer.address != @order.address && customer_posts.blank?
	    		post = Post.new(post_params)
	    		post.customer_id = current_customer.id
	    		post.name = @order.name
	    		post.postcode = @order.postcode
	    		post.address = @order.address
	    	end

	    	current_customer.carts.destroy_all
	    	redirect_to thanks_path
	 	else
	    	redirect_to new_order_path, notice: "購入に失敗しました。お手数ですが、もう一度購入手続きを行ってください。"
	    end
	end

	def show
		@order = Order.find(params[:id])
	end

	def thanks
	end

	private

	def order_params
		params.require(:order).permit(:customer_id, :payment, :postage, :name, :postcode, :address)
	end

	def order_product_params
		params.permit(:order_id, :product_id, :unit_price, :product_quantity, :production_status)
	end

	def post_params
        params.permit(:name, :address, :postcode, :customer_id)
    end

	def ensure_correct_customer
		unless Order.exists?(id: params[:id])						# 一致するorderが存在しない場合
			redirect_to customer_path(current_customer)				# カスタマー画面へリダイレクト
		else
			@order = Order.find(params[:id])
			unless @order.customer_id == current_customer.id		# 取得したorderが他人のものであった場合
				redirect_to customer_path(current_customer)			# カスタマー画面へリダイレクト
			end
		end
	end

	def ensure_carts_exist
		@carts = Cart.where(customer_id: current_customer.id)
		if @carts.blank?
			redirect_to products_path
		end
	end
end
