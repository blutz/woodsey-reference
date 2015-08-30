wrApp = angular.module('wrApp', [])

wrApp.controller 'LoginCtrl', ['$scope', '$http', 'wrApi', 'wrErrorMessages', ($scope, $http, WrApi, WrErrorMessages) ->
  DEFAULT_ERROR = "Sorry, the form could not be submitted and we're not sure what went wrong. Please try again later and report this error."
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
  $scope.thankYou = ''
  $scope.hasVisibleError =
    (field) -> WrErrorMessages.hasVisibleError(field, $scope.formSubmitted)

  $scope.$watch('formError', (newVal, oldVal) ->
    if newVal != oldVal
      $("html, body").animate({ scrollTop: 0 }, 250)
  )

  $scope.submitLoginForm = () ->
    $scope.formError = ''
    $scope.formSubmitted = true
    if $scope.form.$valid
      if $scope.formType == FORM_TYPES.login then login() else register()

  register = () ->
    $scope.submitting = true
    WrApi.register($scope.user).then(successfulRegistration, failedRegistration)
      .finally(() -> $scope.submitting = false)
  successfulRegistration = (r) ->
    $scope.thankYou = "A confirmation email has been sent to #{$scope.user.email}. Please click on the link in the email to activate your account."
  failedRegistration = (r) ->
    if r.data.email? and 'has already been taken' in r.data.email
      $scope.formError = "It looks like you've already registered for an account with that email address. Try resetting your password."
    else
      $scope.formError = DEFAULT_ERROR

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
      $scope.formError = DEFAULT_ERROR
]
