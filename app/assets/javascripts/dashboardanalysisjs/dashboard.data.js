// Preparing the data to be used in graphs
// var data_average = [] ;
// var g = gon.averages ;

// for(var i = 0; i < g.length ; i++ ){
//     data_average.push({ y: g[i].start_date, b: g[i].average_value});
//     }

// console.log(g[i]);





// Morris Chart for average price per week

    !function($) {
        "use strict";


    //Line chart
        var Dashboard = function() {
            this.$body = $("body")
        };

        Dashboard.prototype.init = function() {
        
            Morris.Area({
                element: 'morris-area-example',
                lineWidth: 0,
                data: gon.averages,
                xkey: 'start_date',
                ykeys: ['average_value'],
                labels: ['7 jours'],
                postUnits: '€',
                yLabelFormat: function(y) {return y = Math.round(y)*7 + '€';},
                resize: true,
                lineColors: ['#6e8cd7']
            });

        },
        //init dashboard
        $.Dashboard = new Dashboard, $.Dashboard.Constructor = Dashboard;


    //donut Morris chart
        Morris.Donut({
          element: 'morris-donut-housing',
          data: gon.property_type,
          formatter: function (y, data) { return Math.round((y*1000))/10 + '%' },
          colors: ['#90A3DA', '#72B8E0', '#72B282', '#E9CD7B', '#C9615C', '#413A55', '#E5718D', '#714E9E'],
        });

        Morris.Donut({
          element: 'morris-donut-comments',
          data: gon.comment_data,
          formatter: function (y, data) { return Math.round(y*100) + '%' },
          colors: ['#dcdcdc', '#6e8cd7'],
        });
        
    }(window.jQuery),

    //initializing dashboad
    function($) {
        "use strict";
        $.Dashboard.init();
        // $.MorrisCharts.initcomment();
        // $.MorrisCharts.inithousing();
    }(window.jQuery);






