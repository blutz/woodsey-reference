wrApp = angular.module('wrApp', [])

DEFAULT_ERROR_MESSAGE = "Please fill this out correctly"
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
  $scope.formError = ''

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
    if $scope.form.$valid
      WrApi.login($scope.user).then(successfulLogin, failedLogin)
  successfulLogin = (r) ->
    window.location = '/app'
  failedLogin = (r) ->
    if r.status == 403
      $scope.formError = "That's the wrong password. Try again or reset your password."
    else if r.status == 404
      $scope.formError = "We couldn't find that account. Have you registered yet?"
    else
      $scope.formError = "Sorry, the form could not be submitted and we're not sure what went wrong. Please try again later and report this error."
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

wrApp.directive 'wrAlert', () ->
  template = "
    <div ng-if='alertOn' class='alert-box {{ alertClass }}'>
      <span ng-transclude></span>
      <a href='#' class='close' ng-click='closeAlert()'>&times;</a>
    </div>
  "
  closeAlert = (scope) ->
    scope.alertOn = ''

  link = (scope, element, attrs) ->
    scope.closeAlert = () -> closeAlert(scope)
    scope.alertClass = attrs.class

  return {
    template: template,
    transclude: true,
    restrict: 'E',
    scope: {alertOn: '=alertOn'},
    link: link,
  }
