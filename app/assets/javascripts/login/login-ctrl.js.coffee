wrApp = angular.module('wrApp', [])

wrApp.controller 'LoginCtrl', ['$scope', '$http', 'wrApi', 'wrErrorMessages', ($scope, $http, WrApi, WrErrorMessages) ->
  FORM_TYPES = {
    'login': 0,
    'register': 1,
  }
  $scope.FORM_TYPES = FORM_TYPES
  $scope.formType = FORM_TYPES.login
  $scope.user = {}
  $scope.formSubmitted = false
  $scope.submitting = false
  $scope.formError = ''
  $scope.hasVisibleError =
    (field) -> WrErrorMessages.hasVisibleError(field, $scope.formSubmitted)

  $scope.submitLoginForm = () ->
    $scope.formSubmitted = true
    if $scope.form.$valid
      if $scope.formType == FORM_TYPES.login then login() else register()

  register = () ->
    $scope.submitting = true
    WrApi.register($scope.user).then(successfulRegistration, failedRegistration)
      .finally(() -> $scope.submitting = false)
  successfulRegistration = (r) ->
    console.log 'success'
    console.log r
  failedRegistration = (r) ->
    console.log 'fail'
    console.log r

  login = () ->
    $scope.submitting = true
    WrApi.login($scope.user).then(successfulLogin, failedLogin)
      .finally(() -> $scope.submitting = false)
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
