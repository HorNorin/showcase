angular.module("App").factory("emailValidation", function($http) {
  var service = {};
  service.checkUniqueEmail = function(value) {
    return $http.get("api/users/validate_email", { params: { email: value } });
  }
  
  return service;
})
