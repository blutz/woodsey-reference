Rails.application.routes.draw do

  root 'angular_application#load'
  get '*path' => 'angular_application#load'

end
