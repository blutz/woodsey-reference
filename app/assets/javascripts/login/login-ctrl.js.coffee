wrApp = angular.module('wrApp', [])

wrApp.controller 'LoginCtrl', ['$scope', '$http', 'wrApi', 'wrErrorMessages', ($scope, $http, WrApi, WrErrorMessages) ->
  $scope.formSubmitted = false
  $scope.formError = ''
  $scope.hasVisibleError =
    (field) -> WrErrorMessages.hasVisibleError(field, $scope.formSubmitted)

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
