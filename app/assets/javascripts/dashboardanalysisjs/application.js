//= require jquery
//= require bootstrap.min
//= require pace.min
//= require modernizr.min
//= require wow.min
//= require jquery.nicescroll
//= require dashboardanalysisjs/moment-2.2.1



//= require jquery.app
//= require dashboardanalysisjs/morris.min
//= require dashboardanalysisjs/raphael.min
//= require dashboardanalysisjs/morris.init
//= require dashboardanalysisjs/c3
//= require dashboardanalysisjs/d3.v3.min
//= require dashboardanalysisjs/c3-chart.init

/* ==============================================
             Counter Up
             =============================================== */
            jQuery(document).ready(function($) {
                $('.counter').counterUp({
                    delay: 100,
                    time: 1200
                });
            });