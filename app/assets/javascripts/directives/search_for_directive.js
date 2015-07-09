angular.module("App").directive("searchResultFor", function() {
  return {
    restrict: "AE",
    require: "?ngModel",
    templateUrl: "templates/shows/index.html",
    link: function(scope, elem, attr, ngModel) {
      scope.$watch(attr.searchResultFor, function(params) {  
        if (params) {
          var Resource = scope.$eval(attr.resource);
          Resource.search({title: params}, function(shows) {
            scope.shows = shows;
          });
        }
      });
    }
  };
})
