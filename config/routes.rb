Rails.application.routes.draw do
  resources :drops
  resources :enemy_data
  resources :enemies
  resources :parties
  resources :aps
  resources :garden_names
  resources :skills
  resources :skill_data
  resources :type_names
  resources :statuses
  resources :uploaded_checks
  resources :proper_names
  resources :names
  get 'top_page/privacy'
  root 'top_page#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
