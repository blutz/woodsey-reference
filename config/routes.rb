Rails.application.routes.draw do
  # resources :users
  post 'users', to: 'users#create'

  get 'sessions', to: 'sessions#show'


  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'logout', to: 'user_sessions#destroy'

  get 'app', to: 'main#app', as: 'app'
  get '/register', to: 'main#index', as: 'register'
  get '/', to: 'main#index', as: 'home'
end
