class Customer::PostsController < ApplicationController


  def new
  end


  def show
    @post = Post.select(current_customer)
    @posts = current_customer.posts
    @post = Post.new
  end


  def edit
    @post = Post.find(params[:id])
  end


  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
       flash[:notice] = "配送先を登録しました。"
       redirect_to posts_path(current_customer)
    else
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



end
