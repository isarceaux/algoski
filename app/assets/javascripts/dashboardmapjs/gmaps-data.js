// var points = [
//     ['name1', 59.9362384705039, 30.19232525792222, 12, 'www.google.com'],
//     ['name2', 59.941412822085645, 30.263564729357767, 11, 'www.amazon.com'],
//     ['name3', 59.939177197629455, 30.273554411974955, 10, 'www.stackoverflow.com']
// ];

var points = gon.points

function setMarkers(map, locations) {
        var shape = {
            coord: [1, 1, 1, 20, 18, 20, 18 , 1],
            type: 'poly'
        };

        for (var i = 0; i < locations.length; i++) {
            // var flag = new google.maps.MarkerImage('markers/' + (i + 1) + '.png',
            // new google.maps.Size(17, 19),
            // new google.maps.Point(0,0),
            // new google.maps.Point(0, 19));

            var place = locations[i];
            var myLatLng = new google.maps.LatLng(place[1], place[2]);
            var marker = new google.maps.Marker({
                position: myLatLng,
                map: map,
                // icon: flag,
                shape: shape,
                title: place[0],
                url: place[3]
            });

            google.maps.event.addListener(marker, 'mouseover', function() {
             $('#title-map').text(this.title);
            });

            google.maps.event.addListener(marker, 'click', function() {
             // window.location.href = this.url;
             // window.open(this.url,'_blank');
             $('#title-map').text(this.title);
            });
        }
    }

function initMap() {
        var myOptions = {
            // center: new google.maps.LatLng(59.91823239768787, 30.243222856188822),
            center: new google.maps.LatLng(gon.centerlat, gon.centerlng),
            // center: {lat: points[0][1], points[0][2]},
            zoom: 12,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map"),myOptions);
        setMarkers(map, points);
    }

// function initMap() {
//     var uluru = {lat: -25.363, lng: 131.044};
//     var map = new google.maps.Map(document.getElementById('map'), {
//       zoom: 4,
//       center: uluru
//     });
    
//     var marker = new google.maps.Marker({
//       position: uluru,
//       map: map,
//       title: "Uluru city",
//       url: "www.google.com"
//     });

//     var marker = new google.maps.Marker({
//       position: {lat: -30.363, lng: 131.044},
//       map: map
//     });

//     google.maps.event.addListener(marker, 'click', function() {
//     window.location.href = this.url;
//     });

//   }