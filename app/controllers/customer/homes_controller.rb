class Customer::HomesController < ApplicationController


  def top
    @genres = Genre.where(genre_status: true)
  	@products = Product.all.order(created_at: :desc)
	@rank = []

	@products.each do |product|
		purchased = OrderProduct.where(product_id: product.id).count
		@rank.push([product.id, purchased])
	end
	@rank_sorted = @rank.sort {|a, b|
  		a[1] <=> b[1]
	}.reverse


  end

  def about
  end

end
