Rails.application.routes.draw do
  resources :user_reviews
  resources :reviews
  resources :user_appointments
  resources :appointments
  resources :comments
  resources :medical_files

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "main#index"

  get 'login', to: 'main#login', as: 'login'

  get 'index', to: 'main#index', as: 'index'
  get 'contact', to: 'main#contact', as: 'contact'



end
