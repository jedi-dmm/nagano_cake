class Customer::ProductsController < ApplicationController

	def index
        if params[:genre_id]
            @products = Product.where(genre_id: params[:genre_id])
        else
		    @products = Product.all
        end
		# @products = Product.page(params[:page]).reserse_order(pagenate用)

        # genre一覧（無効のものは表示しない）
        @genres = Genre.where(genre_status: true)
    end

    def show
    	@product = Product.find(params[:id])
        @cart = Cart.new

        # genre一覧（無効のものは表示しない）
        @genres = Genre.where(genre_status: true)
    end

private
    def post_image_params
        params.require(:product).permit(:name, :caption, :price, :image)
    end

end