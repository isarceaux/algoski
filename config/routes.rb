require 'sidekiq/web'

Rails.application.routes.draw do

  get 'dashboards/analysis'

  get 'dashboards/data-table'

  get 'dashboards/profile'

  get 'dashboards', to: 'dashboards#analysis'

  get 'pages/home'
  root 'pages#home'
  
  devise_for :users

  # To have a redirection do dashboards profile view :
  as :user do
    get 'users', :to => 'dashboards#profile', :as => :user_root 
  end

  get '/contact', to: 'pages#contact'
  get '/legal', to: 'pages#legal'

  # get '/users', to: 'pages#home'

  resources :subscriptions, only: [:destroy]

  authenticate :user, lambda { |bu| bu.admin? } do
     mount Sidekiq::Web => '/sidekiq'
  end

  resources :charges

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
