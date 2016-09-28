Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  namespace :admin do
    root "static_pages#home"
    resources :users, except: [:edit, :update]
    resources :categories
    resources :questions, except: [:index]
  end

  root "static_pages#home"
  resources :categories, only: :index
end
