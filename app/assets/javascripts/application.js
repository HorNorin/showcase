// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require bootstrap
//= require rails.validations
//= require jquery.remotipart
//= require angular
//= require angular-animate
//= require angular-resource
//= require_tree .

var ready = function() {
  // remove weird url when sign in with facebook
  if (window.location.hash && window.location.hash == '#_=_') {
    if (window.history && history.pushState) {
      window.history.pushState("", document.title, window.location.pathname);
    } else {
      var scroll = {
        top: document.body.scrollTop,
        left: document.body.scrollLeft
      };
      window.location.hash = '';
      document.body.scrollTop = scroll.top;
      document.body.scrollLeft = scroll.left;
    }
  }
  
  $("input").attr("autocomplete", "off");

  $(":file").on("change", function(){
    var arr = $(this).val().split("\\");
    var name = arr[arr.length - 1];
    $(this).prev().css({color: "#eee"}).text(name);
  });

  $("textarea").on("focus", function(){
    $(this).animate({"rows": "5"}, {duration: 50, step: function(now) { $(this).attr("x", now); }});
  });

  $("textarea").on("blur", function(){
    $(this).removeAttr("rows");
  });
}

$(document).on('ready page:load page:change page:update', ready);

$(document).on("ready page:load", function() {
  angular.bootstrap(document.body, ['App']);
})
