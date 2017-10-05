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
                data: [
                    { y: '2009', b: 10 },
                    { y: '2010', b: 10 },
                    { y: '2011', b: 10 },
                    { y: '2012', b: 20 },
                    { y: '2013', b: 10 },
                    { y: '2014', b: 10 },
                    { y: '2015', b: 10 }
                ],
                xkey: 'y',
                ykeys: ['b'],
                labels: ['Series B'],
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






