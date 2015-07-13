angular.module("App").factory("Show", function($resource) {
  return $resource("/api/shows", {title: "@title"}, {
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
