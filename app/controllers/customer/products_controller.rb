class Customer::ProductsController < ApplicationController

	def index
		@products = Product.all
		# @products = Product.page(params[:page]).reserse_order(pagenate用)
    end

    def show
    	@product = Product.find(params[:id])

    end

private
    def post_image_params
        params.require(:product).permit(:name, :caption, :price, :image)
    end

end