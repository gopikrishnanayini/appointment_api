Rails.application.routes.draw do
  resources :appointments
  resources :doctors
  resources :patients
  resources :users, :social_media_authentications
  post 'users/log_in' => 'users#log_in'
  devise_scope :user do
    post 'facebook' => 'callbacks'
    post 'google_oauth2' => 'callbacks'
  end
end
