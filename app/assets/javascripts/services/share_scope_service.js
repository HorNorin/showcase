angular.module("App").factory("shareScopeService", function($rootScope) {
  var scope = $rootScope.$new(true);
  scope.data = {};
  return scope;
})
