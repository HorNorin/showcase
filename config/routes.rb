Rails.application.routes.draw do
  root "statics#index"
  
  devise_for :user, controllers: { registrations: "registrations" }
  
  devise_for :admin, class_name: "User", controllers: { sessions: "admin/sessions" }
  
  get "/auth/twitter/callback" => "omniauth_callbacks#twitter"
  get "/auth/facebook/callback" => "omniauth_callbacks#facebook"
  
  namespace :admin do
    resources :shows
  end
end
