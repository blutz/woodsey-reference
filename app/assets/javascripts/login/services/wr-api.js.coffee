wrApp = angular.module('wrApp')

wrApp.factory 'wrApi', ['$http', ($http) ->
  # Set up CSRF tokens
  csrfToken = $('meta[name="csrf-token"]').attr('content')
  $http.defaults.headers.common['X-CSRF-Token'] = csrfToken

  login = (user) -> $http.post('/login', user)
  register = (user) ->
    $http.post('/users', user)

  return {
    login: login
    register: register
  }
]
