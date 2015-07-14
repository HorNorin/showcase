angular.module("App", ["ngResource", "ngAnimate", "ngMessages"])

.factory "Show", ($resource) ->
  return $resource "/api/shows", { title: "@title" }, {
    search:
      method: "GET"
      params:
        action: "index"
        title: "@title"
      isArray: true
  }

.factory "emailValidation", ($http) ->
  service =
    checkUniqueEmail: (value) ->
      return $http.get "api/users/validate_email", { params: { email: value } }
  return service

.factory "shareScopeService", ($rootScope) ->
  scope = $rootScope.$new(true)
  scope.data = {}
  return scope

.controller "ShowsController", ($scope, Show, shareScopeService) ->
  $scope.show = shareScopeService.data
  $scope.resource = Show
  return

.directive "confirm", ->
  return {
    restrict: "AE"
    require: "ngModel"
    scope:
      confirm: "="
    link: (scope, elem, attr, ngModel) ->
      scope.$watch ->
        ngModel.$validate();
      
      ngModel.$validators.confirm = (value) ->
        return value == scope.confirm;
  }

.directive "searchResultFor", ->
  return {
    restrict: "AE"
    require: "?ngModel"
    templateUrl: "templates/shows/index.html"
    link: (scope, elem, attr, ngModel) ->
      scope.$watch attr.searchResultFor, (params) ->  
        if params
          resource = scope.$eval(attr.resource)
          resource.search {title: params}, (shows) ->
            scope.shows = shows;
  }

.directive "unique", (emailValidation) ->
  return {
    restrict: "AE"
    require: "ngModel"
    link: (scope, elem, attr, ngModel) ->
      elem.bind "blur", (e) ->
        emailValidation.checkUniqueEmail(ngModel.$viewValue)
          .success (unique) ->
            ngModel.$setValidity("unique", unique);
          .error (status) ->
            ngModel.$setValidity("unique", false);
  }
