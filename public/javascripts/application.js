var Rootfolio = {
    map: null,
    setupMap: function(element) {
        var latlng = new google.maps.LatLng(29.762778, -95.383056);
        var myOptions = {
            zoom: 8,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          };
          Rootfolio.map = new google.maps.Map(element,
              myOptions);

    },
    plotIntrigueOnMap: function(intrigueData) {
        if(!intrigueData.address ||
            !intrigueData.address.latitude ||
            !intrigueData.address.longitude) {
            return;
        }
        var lat = intrigueData.address.latitude;
        var lng = intrigueData.address.longitude;
        var latlng = new google.maps.LatLng(lat, lng);
        var marker = new google.maps.Marker({
          position: latlng,
          title: intrigueData.name
        });
        marker.setMap(Rootfolio.map);
    },
    moveMap: function(lat, lng) {
        Rootfolio.map.panTo(new google.maps.LatLng(lat, lng))
    }
};