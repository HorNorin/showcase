angular.module("App")
  .directive("confirm", function() {
    return {
      restrict: "AE",
      require: "ngModel",
      scope: { confirm: "=" },
      link: function(scope, elem, attr, ngModel) {
        scope.$watch(function() {
          ngModel.$validate();
        });
        
        ngModel.$validators.confirm = function(value) {
          return value === scope.confirm;
        }
      }
    };
  })
