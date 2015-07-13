angular.module("App")
  .directive("unique", function(emailValidation) {
    return {
      restrict: "AE",
      require: "ngModel",
      link: function(scope, elem, attr, ngModel) {
        elem.bind("blur", function(e) {
          emailValidation.checkUniqueEmail(ngModel.$viewValue)
            .success(function(unique) {
              ngModel.$setValidity("unique", unique);
            })
            .error(function(status) {
              ngModel.$setValidity("unique", false);
            });
        });
      }
    };
  })
