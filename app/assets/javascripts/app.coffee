angular.module("App", ["ngResource", "ngAnimate", "ngMessages", "ngRoute", "Devise"])

.config ($routeProvider, $locationProvider, AuthProvider) ->
  $routeProvider.when "/", {
    templateUrl: "templates/index.html"
    controller: "HomeController"
  }
  
  $routeProvider.when "/shows/:id", {
    templateUrl: "templates/shows/show.html"
    controller: "ShowsController"
  }
  
  $routeProvider.when "/sign_in", {
    templateUrl: "templates/sessions/sign_in.html",
    controller: "SessionsController"
  }
  
  $routeProvider.when "/sign_out", {
    templateUrl: "templates/sessions/sign_in.html",
    controller: "SessionsController"
  }
  
  $locationProvider.html5Mode true
  
  AuthProvider.loginPath "/user/sign_in.json"
  AuthProvider.logoutPath "/user/sign_out.json"
  AuthProvider.logoutMethod "GET"

.factory "Show", ($resource) ->
  return $resource "/api/shows/:id", { id: "@id", title: "@title" }, {
    search:
      method: "GET"
      params:
        action: "index"
        title: "@title"
      isArray: true
    index:
      method: "GET"
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

.controller "HomeController", ($scope, Show) ->
  $scope.data = Show.index()
  
  $scope.click = (num) ->
    $scope.data = Show.index({ page: num })
  return

.controller "ShowsController", ($scope, $sce, $routeParams, Show) ->
  $scope.trustSrc = (src) ->
    return $sce.trustAsResourceUrl(src)
  
  $scope.data =
    show: Show.get({id: $routeParams.id})
  return

.controller "SessionsController", ($scope, Auth) ->
  Auth.currentUser().then (user) ->
    if user
      config =
        headers:
          'X-HTTP-Method-Override': 'GET'
          
      Auth.logout config
        .then (user) ->
          console.log "logout"
          console.log Auth.isAuthenticated()
        , (error) ->
          console.log "error"
  , (error) ->
    $scope.user = {}
    config =
      headers:
        "X-HTTP-Method-Override": "POST"
    
    $scope.signIn = ->
      console.log $scope.user
      Auth.login $scope.user, config
        .then (user) ->
          console.log user
          console.log Auth.isAuthenticated()

        , (error) ->
          console.log "error"
  
  return

.controller "SearchController", ($scope, Show, shareScopeService) ->
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
    templateUrl: "templates/shows/search.html"
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
