
var drawMap = function (farm){

  handler = Gmaps.build('Google')
  handler.buildMap({ provider: {zoom:11, center: new google.maps.LatLng(farm.location.latitude, farm.location.longitude)}, internal: {id: 'map'}}, function(){

    markers = handler.addMarkers([
      {
        "lat": farm.location.latitude,
        "lng": farm.location.longitude,
        // "picture": {
        //   "url": "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png",
        //   "width":  32,
        //   "height": 32
        // },
        "infowindow": '<h5>'+farm.farm.name+'</h5>'
      }
    ]);
  });

}
