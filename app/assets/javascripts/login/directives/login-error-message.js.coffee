wrApp = angular.module('wrApp')

wrApp.directive 'loginErrorMessage', ['wrErrorMessages', (WrErrorMessages) ->
  template = "
    <small class='error' ng-if='hasVisibleError(field)'>
      {{ singleErrorMessage(field) }}
    </small>
  "
  link = (scope, element, attrs) ->
    scope.hasVisibleError = (field) -> WrErrorMessages.hasVisibleError(field, scope.$parent.formSubmitted)
    scope.singleErrorMessage = WrErrorMessages.singleErrorMessage

  return {
    template: template,
    restrict: 'E',
    link: link,
    scope: {
      field: '=for'
    },
  }
]
