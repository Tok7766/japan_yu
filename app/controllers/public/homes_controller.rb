class Public::HomesController < ApplicationController

  def top
  end


  def guest_sign_in
    customer = Customer.find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.name = "ゲスト会員"
      customer.introduction = "ゲスト会員でログイン中です"
      customer.password = SecureRandom.urlsafe_base64
    end
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end


end
