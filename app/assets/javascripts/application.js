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
//= require turbolinks
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
  
  // toggle label color to make it brigther or darker
  // when textbox get focus or blur accordingly
  $(".form-control").on("focus", function(){
    $(this).prev().css({color: "#FFFFFF"});
  });
  
  $(".form-control").on("blur", function(){
    $(this).prev().css({color: "#CCCCCC"});
  });
  
  $("input").attr("autocomplete", "off");
}

$(document).on('ready page:load', ready);
