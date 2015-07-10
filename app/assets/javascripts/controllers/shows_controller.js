angular.module("App").controller("ShowsController", function($scope, Show, shareScopeService) {
  $scope.show = shareScopeService.data;
  $scope.resource = Show;
});
