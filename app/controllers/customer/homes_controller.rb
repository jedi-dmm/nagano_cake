class Customer::HomesController < ApplicationController


  def top
    @genres = Genre.where(genre_status: true)
  	@products = Product.all
  end

  def about
  end

end
