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
  get '/doctors/:id', to: 'main#show', as: 'doctor_id'
  get 'price', to: 'main#price', as: 'price'
  get 'lab', to: 'main#lab', as: 'lab'

  get 'appointment', to: 'appointments#index'

  # Doctor
  get 'doctor', to: 'doctor#doctor'
  get 'issue_prescription', to: 'doctor#prescription'
  get 'set_appointment', to: 'doctor#appointments'    
  get 'doctor/appointments.json', to: 'appointments#index_json'
  get 'doctor_contact', to: 'doctor#doctor_contact', as: 'doctor_contact'
  get 'doctor_login', to: 'doctor#doctor_login', as: 'doctor_login'
  get 'doctor_doctors', to: 'doctor#doctor_doctors', as: 'doctor_doctors'
  get 'doctor_lab', to: 'doctor#doctor_lab', as: 'doctor_lab'
  get 'doctor_price', to: 'doctor#doctor_price', as: 'doctor_price'
  get 'doctor_help', to: 'doctor#doctor_help', as: 'doctor_help'
  get 'doctor_profile', to: 'doctor#doctor_profile', as: 'doctor_profile'




  
  post 'doctor/appointments', to: 'doctor#create_appointment'

  #Patient
  get 'patient', to: 'patient#patient', as: 'patient'

  get 'patient/appointments', to: 'patient#appointments', as: 'patient_appointments'
  get 'patient/lab_results', to: 'patient#lab_results', as: 'patient_lab_results'
  get 'patient/prescriptions', to: 'patient#prescriptions', as: 'patient_prescriptions'
  get 'patient/reviews', to: 'patient#reviews', as: 'patient_reviews'
  get 'patient/logout_patient', to: 'patient#logout_patient', as: 'logout_patient'
  get 'patient/help_patient', to: 'patient#help_patient', as: 'help_patient'
  get 'patient/contact_patient', to: 'patient#contact_patient', as: 'contact_patient'
  get 'patient/doctors_patient', to: 'patient#doctors_patient', as: 'doctors_patient'
  get 'patient/price_patient', to: 'patient#price_patient', as: 'price_patient'
  get 'patient/lab_patient', to: 'patient#lab_patient', as: 'lab_patient'
  get 'patient/profile_patient', to: 'patient#profile_patient', as: 'profile_patient'


  #Labworker
  get 'labworker', to: 'labworker#labworker', as: 'labworker'
  get 'patients', to: 'labworker#patients', as: 'patients'
  get 'comresearch', to: 'labworker#comresearch', as: 'comresearch'
  get 'exeresearch', to: 'labworker#exeresearch', as: 'exeresearch'
  get 'logout_labworker', to: 'labworker#logout_labworker', as: 'logout_labworker'
  get 'profile', to: 'labworker#profile_labworker', as:'profile'

  #Admin
  get 'admin', to: 'admin#admin', as: 'admin'
  get 'users_list', to: 'admin#users_list', as: 'users_list'
  get 'admin_contact', to: 'admin#admin_contact', as: 'admin_contact'
  get 'admin_login', to: 'admin#admin_login', as: 'admin_login'
  get 'admin_doctors', to: 'admin#admin_doctors', as: 'admin_doctors'
  get 'admin_lab', to: 'admin#admin_lab', as: 'admin_lab'
  get 'admin_price', to: 'admin#admin_price', as: 'admin_price'
  get 'admin_help', to: 'admin#admin_help', as: 'admin_help'
  get 'admin_profile', to: 'admin#admin_profile', as: 'admin_profile'


  resources :medical_files do
    collection do
      get 'prescription'
    end
  end

  get 'admin/new_user', to: 'admin#new_user'
  post 'admin/create_user', to: 'admin#create_user'
  get 'admin/edit_user/:id', to: 'admin#edit_user', as: 'edit_user'
  patch 'admin/update_user/:id', to: 'admin#update_user', as: 'update_user'
  delete 'admin/destroy_user/:id', to: 'admin#destroy_user', as: 'destroy_user'

end