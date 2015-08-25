Rails.application.routes.draw do
  resources :users

  get '/', to: 'main#index'
end
