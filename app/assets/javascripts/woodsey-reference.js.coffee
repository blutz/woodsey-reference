wrApp = angular.module('wrApp', [])

wrApp.controller 'LoginCtrl', ['$scope', '$http', 'wrApi', ($scope, $http, WrApi) ->
  window.asdf = $scope
  $scope.test = 'hi'
  successfulLogin = (r) ->
    window.location = '/app'
  failedLogin = (r) ->
    console.log "fail"
    console.log r
  $scope.login = () ->
    WrApi.login($scope.user).then(successfulLogin, failedLogin)
]

wrApp.factory 'wrApi', ['$http', ($http) ->
  # Set up CSRF tokens
  csrfToken = $('meta[name="csrf-token"]').attr('content')
  $http.defaults.headers.common['X-CSRF-Token'] = csrfToken

  login = (user) -> $http.post('/login', user)

  return {
    login: login
  }
]
