class Public::HomesController < ApplicationController
  def top
  end

  def about
  end
  
  def guest
    customer = Customer.new(customer_params)
    customer.name = "ゲストユーザー"
    customer.email = SecureRandom.alphanumeric(15) + "@email.com"
    customer.introduction = "ゲストログイン中です。"
    customer.password = SecureRandom.alphanumeric(10)
    customer.save
    sign_in customer
    redirect_to root_path
  end
  
  private

  def customer_params
    params.permit(:name, :email, :introduction, :password)
  end
end
