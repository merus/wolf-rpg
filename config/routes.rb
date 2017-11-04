Rails.application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    member do
      patch :password
    end
  end
  resources :campaigns do
    member do
      get :join
      get :invite
      get :deny
      get :clear
      get :admin
      get :combat
      patch :order
      patch :fight
    end
  end
  resources :characters do
    member do
      get :export
      patch :stats
      patch :items
      patch :skills
      patch :abilities
      patch :synergy_stats
    end

    collection do
      post :import
    end
  end

  get '/rules', to: 'static_pages#rules'

  resource :rules, controller: :static_pages, only: :index do
    get :core
    get :combat
    get :race
    get :skills
    get :abilities
    get :synergy
    get :item
    get :monster
    get :setting
  end

  get '/contact', to: 'static_pages#contact'

  # Sign up/in/out pages

  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'

  root to: 'static_pages#home'

end
