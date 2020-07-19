class Admin::GenresController < ApplicationController
  def index
  	@genre = Genre.new
  	@genres = Genre.all
  end

  def create
  	@genre = Genre.new(genre_params)
  	@genres = Genre.all
  	if @genre.save!
  		redirect_to genres_path
  	else
  		render 'genres/index'
  	end
  end

  def edit
  	@genre = Genre.find(params[:id])
  end

  def update
  	@genre = Genre.find(params[:id])
  	if @genre.update(genre_params)
  		redirect_to genres_path
  	else
  		render 'genres/edit'
  	end
  end

  private
  def genre_params
  	params.require(:genre).permit(:name,:genre_status)
  end
end
