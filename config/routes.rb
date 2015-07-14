Rails.application.routes.draw do
  root "home#index"
  
  devise_for :user, controllers: { registrations: "registrations", sessions: "sessions" }
  devise_scope :user do
    get "/sign_in" => "sessions#new", as: :sign_in
    get "/sign_out" => "devise/sessions#destroy", as: :sign_out
    get "/sign_up" => "registrations#new", as: :sign_up
  end
  
  resources :shows, only: [:index, :show]
  
  devise_for :admin, class_name: "User", controllers: { sessions: "admin/sessions" }, only: :sessions
  namespace :admin do
    root "shows#index"
    resources :shows
  end
  
  get "/auth/twitter/callback" => "omniauth_callbacks#twitter"
  get "/auth/facebook/callback" => "omniauth_callbacks#facebook"
  
  namespace :api do
    get 'users/validate_email' => "users#validate_email"
    resources :shows, only: [:index, :show]
  end
end
