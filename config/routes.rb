Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#home'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  get    '/places',   to:  'locations#categories'
  get '/places/:category', to: 'locations#venues'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get    '/wallet',  to: 'wallet#Mywallet'
  post   '/',  to: 'homes#create_stock'
  resources :users
  
end
