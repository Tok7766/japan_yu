Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
   scope module: :public do
    root to: 'homes#top'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in' 
    get "search" => "searches#search"

    resources :post_images, only: [:index, :show, :create, :edit, :update, :destroy] do
     resources :post_image_comments, only: [:create, :destroy]  
     resource :favorites, only: [:create, :destroy]
    end
    
    get '/customers/:id/unsubscribe' => 'customers#unsubscribe' , as: 'unsubscribe'
    patch '/customers/:id/withdraw' => 'customers#withdraw' , as: 'withdraw'
    
    resources :customers, only: [:show, :index, :edit, :update] do
      member do
      get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings' , as: 'followings'
      get 'followers' => 'relationships#followers' , as: 'followers'
    end  
   end
   
   namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :post_images, only:[:index, :show, :edit, :update, :destroy]
   end  
end
