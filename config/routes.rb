Rails.application.routes.draw do

  namespace :admin do
    resources :users, except: [:edit, :update]
  end

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  root "static_pages#home"
end
