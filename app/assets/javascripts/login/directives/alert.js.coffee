wrApp = angular.module('wrApp')

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

