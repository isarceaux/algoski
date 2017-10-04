require 'sidekiq/web'

Rails.application.routes.draw do

  get 'dashboards/analysis'

  get 'dashboards/data-table'

  get 'dashboards/profile'

  get 'dashboards', to: 'dashboards#profile'

  get 'subscriptions/destroy'

  get 'customers/show'

  get 'pages/home'

  devise_for :users
  # resources :classifieds
  # get '/search', to: 'classifieds#search'
  
  # root 'classifieds#search'
  root 'pages#home'

  # get 'stations/show'

  get '/contact', to: 'pages#contact'
  get '/legal', to: 'pages#legal'

  # get '/dashboard', to:'users#dashboard'

  get '/users', to: 'pages#home'

  resources :subscriptions, only: [:destroy]

  # authenticate :user, lambda { |bu| bu.super_admin? } do
     mount Sidekiq::Web => '/sidekiq'
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
