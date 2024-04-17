Rails.application.routes.draw do
  resources :user_reviews
  resources :reviews
  resources :user_appointments
  resources :appointments
  resources :comments
  resources :medical_files
  devise_for :users, controllers: { sessions: 'users/sessions' }
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

  # Doctor
  get 'doctor', to: 'doctor#doctor'
  
  #Patient
  get 'patient', to: 'patient#patient'

  get 'patient/appointments', to: 'patient#appointments', as: 'patient_appointments'
  get 'patient/tests', to: 'patient#lab_tests', as: 'patient_lab_tests'
  get 'patient/prescriptions', to: 'patient#prescriptions', as: 'patient_prescriptions'

  #Labworker
  get 'labworker', to: 'labworker#labworker'

  #Admin
  get 'admin', to: 'admin#admin'

  get 'admin/new_user', to: 'admin#new_user'
  post 'admin/create_user', to: 'admin#create_user'
  get 'admin/edit_user/:id', to: 'admin#edit_user', as: 'edit_user'
  patch 'admin/update_user/:id', to: 'admin#update_user', as: 'update_user'
  delete 'admin/destroy_user/:id', to: 'admin#destroy_user', as: 'destroy_user'


end
