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
    get '/about' => 'homes#about' , as: 'about'
    post '/guest_sign_in' => 'homes#guest' 

    resources :post_images, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    
    get '/customers/my_page' => 'customers#show'
    get '/customers/information/edit' => 'customers#edit'
    get '/customers/unsubscribe' => 'customers#unsubscribe'
    patch '/customers/information' => 'customers#update'
    patch '/customers/withdraw' => 'customers#withdraw'

    
  end
end
