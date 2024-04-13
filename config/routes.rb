Rails.application.routes.draw do
  resources :user_reviews
  resources :reviews
  resources :user_appointments
  resources :appointments
  resources :comments
  resources :medical_files
  resources :users

  devise_for :users

  get 'my_appointments', to: 'users#patients#my_appointments', as: 'my_appointments'
  get 'my_tests', to: 'users#patients#my_tests', as: 'my_tests'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #root "medical_files#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "main#index"
  
  get 'login', to: 'main#login', as: 'login'

  get 'index', to: 'main#index', as: 'index'
  get 'contact', to: 'main#contact', as: 'contact'

  




  get 'help', to: 'main#help', as: 'help'

  get 'doctors', to: 'main#doctors', as: 'doctors'

  get 'price', to: 'main#price', as: 'price'

  get 'lab', to: 'main#lab', as: 'lab'

  get 'doctor', to: 'users#doctor'
end
