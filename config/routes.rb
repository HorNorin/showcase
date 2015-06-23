Rails.application.routes.draw do
  root "statics#index"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
end
