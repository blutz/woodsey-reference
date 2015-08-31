wrApp = angular.module('wrApp')

wrApp.directive 'wrRegistrationCode', ['$q','wrApi', ($q, WrApi) ->

  link = (scope, element, attrs, ctrl) ->
    ctrl.$asyncValidators.registrationCode = (modelValue, viewValue) ->
      if ctrl.$isEmpty(modelValue)
        return $q.reject()
      defer = $q.defer()
      WrApi.getSessionByRegistrationCode(modelValue)
        .then((r) ->
          defer.resolve()
        , () ->
          defer.reject()
        )
      return defer.promise

  return {
    require: 'ngModel',
    link: link,
  }
]
