class ApplicationController < ActionController::Base
 
  before_action :authenticate_customer!, except: [:top]
  before_action :configure_permitted_parameters,if: :devise_controller?
  
   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name, :introduction, :encrypted_password, :email])
   end

end
