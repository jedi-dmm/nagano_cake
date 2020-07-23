class Admin::ProductsController < ApplicationController
    before_action :authenticate_admin!

	def index
        @products = Product.page(params[:page]).reverse_order
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            redirect_to product_path(product.id)
        else
           render :new
        end
    end

    def new
        @product = Product.new
    end

    def edit
        @product = Product.find(params[:id])
    end

    def show
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        if product.update(product_params)
           redirect_to product_path(@product.id)
        else
           render :edit
        end
    end

  private

    def product_params
        params.require(:product).permit(:name, :caption, :genre_id, :price, :image, :sale_status)
    end
end
