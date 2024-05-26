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

  get 'appointment', to: 'appointments#index'

  # Doctor
  get 'doctor', to: 'doctor#doctor'
  get 'issue_prescription', to: 'doctor#prescription'
  get 'set_appointment', to: 'doctor#appointments'    
  get 'doctor/appointments.json', to: 'appointments#index_json'
  
  post 'doctor/appointments', to: 'doctor#create_appointment'

  #Patient
  get 'patient', to: 'patient#patient'

  #Labworker
  get 'labworker', to: 'labworker#labworker', as: 'labworker'
  get 'patients', to: 'labworker#patients', as: 'patients'
  get 'comresearch', to: 'labworker#comresearch', as: 'comresearch'
  get 'exeresearch', to: 'labworker#exeresearch', as: 'exeresearch'
  get 'logout', to: 'labworker#logout', as: 'logout'

  #Admin
  get 'admin', to: 'admin#admin'
  resources :medical_files do
    collection do
      get 'prescription'
    end
  end
end
