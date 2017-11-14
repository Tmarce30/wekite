Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :photos, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  resources :users, only: [:show] do
    resources :photos, only: [:index]
    resources :favorites, only: [:index]
  end

  resources :spots, except: [:destroy] do
    resources :reviews, only: [:create, :update, :destroy]
  end
end
