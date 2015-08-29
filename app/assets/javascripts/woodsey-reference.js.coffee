wrApp = angular.module('wrApp', [])

DEFAULT_ERROR_MESSAGE = "Something is wrong"
ERROR_MESSAGES = {
  'required': 'This is required',
  'email': "This doesn't look like an email address",
  'minlength': "This isn't long enough",
}
ERROR_MESSAGES_BY_FIELD = {
  'password': {
    'minlength': "Your password must be at least 6 characters."
  }
}

wrApp.controller 'LoginCtrl', ['$scope', '$http', 'wrApi', ($scope, $http, WrApi) ->
  $scope.formSubmitted = false

  $scope.hasVisibleError = (field) ->
    (field.$touched or $scope.formSubmitted) and
    (field.$invalid)

  $scope.singleErrorMessage = (field) ->
    firstError = Object.keys(field.$error)[0]
    errorMessage = getErrorMessage(field.$name, firstError)

  getErrorMessage = (field, error) ->
    message = ERROR_MESSAGES_BY_FIELD[field]?[error]
    if not message
      message = ERROR_MESSAGES[error]
    if not message
      message = DEFAULT_ERROR_MESSAGE
    return message

  $scope.login = () ->
    $scope.formSubmitted = true
    WrApi.login($scope.user).then(successfulLogin, failedLogin)
  successfulLogin = (r) ->
    window.location = '/app'
  failedLogin = (r) ->
    console.log "fail"
    console.log r
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
