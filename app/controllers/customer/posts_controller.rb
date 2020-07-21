class Customer::PostsController < ApplicationController


  def new
  end


  def show
    @post = Post.new
    @customer = current_customer
    @posts = Post.all
  end


  def edit
    @post = Post.find(params[:id])
  end


  def create
    @post = Post.new(post_params = current_customer)
    if @post.save
       flash[:notice] = "配送先を登録しました。"
       redirect_to posts_path(current_customer)
    else
       @customer = current_customer
       @posts = Post.all
       render :show
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "配送先を削除しました。"
    redirect_to posts_path
  end


  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       flash[:notice] = "配送先を編集しました。"
       redirect_to posts_path(current_customer)
    else
      render "edit"
    end
  end




  private


    def post_params
      params.require(:post).permit(:name, :address, :postcode, :customer_id)
    end


    def correct_customer
      customer = Post.find(params[:id]).customer
      unless current_customer.id == customer.id
        redirect_to posts_path
      end
    end



end
