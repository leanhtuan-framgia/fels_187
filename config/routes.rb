Rails.application.routes.draw do

  namespace :admin do
    resources :users, except: [:edit, :update]
  end

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  namespace :admin do
    root "static_pages#home"
    resources :users, except: [:edit, :update]
    resources :categories
  end

  root "static_pages#home"
end
