Rails.application.routes.draw do
  # resources :users


  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

  get 'app', to: 'main#app', as: 'app'
  get '/register', to: 'main#index', as: 'register'
  get '/', to: 'main#index', as: 'home'
end
