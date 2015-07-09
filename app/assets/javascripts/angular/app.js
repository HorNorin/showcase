angular.module("App", ["ngResource", "ngAnimate"])
  .factory("Show", function($resource) {
    return $resource("/shows.json", {title: "@title"}, {
      search: {
        method: "GET",
        params: {
          action: "index",
          title: "@title"
        },
        isArray: true
      }
    });
  })
  .controller("MyController", function($scope, Show) {     
    $scope.shows = false;
     
    $scope.complete = function() {
      Show.search({title: $scope.title}, function(shows) {
        $scope.shows = shows;
      });
      
      // $("#search").autocomplete({
      //   source: $scope.shows
      // });
    }
  });
