// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery.easing.1.3.min
//= require select2
//= require SmoothScroll
//= require bootstrap.min

//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {

          $('.navbar-nav a').bind('click', function(event) {
              var $anchor = $(this);
              $('html, body').stop().animate({
                  scrollTop: $($anchor.attr('href')).offset().top - 0
              }, 1500, 'easeInOutExpo');
              event.preventDefault();
          });
      });

$(function() {
  $('.form-control').select2();
});