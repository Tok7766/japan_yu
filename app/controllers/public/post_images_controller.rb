class Public::PostImagesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @post_images = PostImage.all
  end

  def new
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_image_comment = current_customer.post_image_comments.new
  end

  def edit
    @post_image = PostImage.find(params[:id])
  end
  
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    if @post_image.save
     redirect_to customer_path(current_customer)
    else
     @post_images = PostImage.all
     render "index"
    end 
  end
  
  def update
     @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      redirect_to post_image_path(@post_image), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end
  
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to customer_path(current_customer)
  end
  
  private
  
  def post_image_params
    params.require(:post_image).permit(:title, :body, :image)
  end
end
