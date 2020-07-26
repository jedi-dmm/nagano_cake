class Customer::HomesController < ApplicationController


  def top
    @genres = Genre.where(genre_status: true)
  	@products = Product.all.order(created_at: :desc)
  	@products = Product.limit(4)
  end

  def about
  end

end
