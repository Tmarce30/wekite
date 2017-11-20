Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

devise_for :users,
      controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  root to: 'pages#home'

  resources :pictures, only: [:create, :destroy]
  resources :favorites, only: [:destroy]
  resources :checkins, only: [:destroy]

  resources :users, only: [:show] do
    resources :pictures, only: [:index]
    resources :favorites, only: [:index]
  end

  resources :spots, except: [:destroy] do
    resources :reviews, only: [:create, :update, :destroy]
    resources :checkins, only: [:create]
    resources :favorites, only: [:create]
    resources :pictures, only: [:create]
    resources :weathers, only: [:create]
  end

  mount Attachinary::Engine => "/attachinary"
end
