Rails.application.routes.draw do
  require "sidekiq/web"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  namespace :admin do
    root "lessons#index"
    resources :users, except: [:edit, :update]
    resources :questions, only: [:new, :create]
    resources :categories
    resources :questions, except: [:index]
    resources :lessons, except: [:new, :show, :destroy]
  end

  root "static_pages#home"
  resources :lessons, except: [:destroy]
  resources :categories, only: :index
  resources :users, only: [:index, :show]
  resources :relationships, only: [:index, :create, :destroy]

  mount Sidekiq::Web, at: "/sidekiq"
end
