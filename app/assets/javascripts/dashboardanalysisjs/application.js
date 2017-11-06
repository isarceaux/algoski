//= require jquery.min
//= require jquery_ujs
//= require bootstrap.min
//= require pace.min
//= require modernizr.min
//= require wow.min
//= require jquery.scrollTo.min
//= require jquery.nicescroll
//= require dashboardanalysisjs/moment-2.2.1

//Counterup
//= require dashboardanalysisjs/waypoints.min
//= require dashboardanalysisjs/jquery.counterup.min

//Morris chart
//= require dashboardanalysisjs/raphael.min
//= require dashboardanalysisjs/morris.min

//C3 chart
//= require dashboardanalysisjs/d3.v3.min
//= require dashboardanalysisjs/c3


//= require jquery.app
//= require dashboardanalysisjs/dashboard.data

/* ==============================================
             Counter Up
             =============================================== */
            jQuery(document).ready(function($) {
                $('.counter').counterUp({
                    delay: 100,
                    time: 1200
                });
            });