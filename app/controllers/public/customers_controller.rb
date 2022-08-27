class Public::CustomersController < ApplicationController

 before_action :authenticate_customer!

  def index
   @customers = Customer.all
   @customer = current_customer
  end

  def show
   @customer = Customer.find(params[:id])
   @post_image = PostImage.new
   @post_images = @customer.post_images.all
  end

  def edit
   @customer = current_customer
  end

  def update
   @customer = current_customer
   if @customer.update(customer_params)
     redirect_to customer_path(current_customer)
   else
     render "edit"
   end
  end

  def unsubscribe
   @customer = current_customer
  end

  def withdraw
   @customer = current_customer
   @customer.update(is_deleted: true)
   reset_session
   flash[:notice] = "退会処理を実行いたしました"
   redirect_to root_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites= Favorite.where(Customer_id: @customer.id).pluck(:post_image_id)
    @favorite_post_images = PostImage.find(favorites)
  end

  private
  def customer_params
   params.require(:customer).permit(:name, :mail, :introduction, :encrypted_password, :profile_image)
  end
end
