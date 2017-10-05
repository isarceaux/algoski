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
                yLabelFormat: function(y) {return y = Math.round(y)*7;},
                resize: true,
                lineColors: ['#6e8cd7']
            });

        },
        //init dashboard
        $.Dashboard = new Dashboard, $.Dashboard.Constructor = Dashboard;


    //donut Morris chart
         var MorrisCharts = function() {};

        //creates Donut chart
        MorrisCharts.prototype.createDonutChart = function(element, data, colors) {
            Morris.Donut({
                element: element,
                data: data,
                colors: colors
            });
        },
        MorrisCharts.prototype.initcomment = function() {

            //creating donut chart
            var $donutData = [
                    {label: "Aucun commentaire", value: 75},
                    {label: "1 commentaire ou +", value: 25},
                ];
            this.createDonutChart('morris-donut-comments', $donutData, ['#dcdcdc', '#6e8cd7']);
        },
        $.MorrisCharts = new MorrisCharts, $.MorrisCharts.Constructor = MorrisCharts

        MorrisCharts.prototype.inithousing = function() {

            //creating donut chart
            var $donutData = [
                    {label: "Chalet", value: 15},
                    {label: "Appartement", value: 65},
                    {label: "Autres", value: 20},
                ];
            this.createDonutChart('morris-donut-housing', $donutData, ['#79D1CF', '#4D5360', '#95D7BB']);
        },
        $.MorrisCharts = new MorrisCharts, $.MorrisCharts.Constructor = MorrisCharts
        
    }(window.jQuery),

    //initializing dashboad
    function($) {
        "use strict";
        $.Dashboard.init();
        $.MorrisCharts.initcomment();
        $.MorrisCharts.inithousing();
    }(window.jQuery);






