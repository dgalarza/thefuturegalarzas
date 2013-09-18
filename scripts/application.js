(function() {
  var bounds, directions_service, generateNaninasMarker, h_map, hotel_map, hotel_map_options, n_map, naninas, naninas_lat_lng, naninas_map, naninas_map_options, saddlebrook, saddlebrook_lat_lng;

  google.maps.visualRefresh = true;

  naninas = {
    lat: 40.7889499,
    lng: -74.17179999999999
  };

  saddlebrook = {
    lat: 40.9045834,
    lng: -74.1014655
  };

  naninas_lat_lng = new google.maps.LatLng(naninas.lat, naninas.lng);

  saddlebrook_lat_lng = new google.maps.LatLng(saddlebrook.lat, saddlebrook.lng);

  generateNaninasMarker = function(map) {
    return new google.maps.Marker({
      position: naninas_lat_lng,
      map: map
    });
  };

  naninas_map_options = {
    scrollwheel: false,
    disableDoubleClickZoom: true,
    zoom: 15,
    center: naninas_lat_lng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  naninas_map = $('#venue .bg-map');

  n_map = new google.maps.Map(naninas_map[0], naninas_map_options);

  generateNaninasMarker(n_map);

  hotel_map_options = {
    scrollwheel: false,
    disableDoubleClickZoom: true,
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    center: new google.maps.LatLng(naninas.lat, naninas.lng)
  };

  hotel_map = $('#shuttles .bg-map');

  h_map = new google.maps.Map(hotel_map[0], hotel_map_options);

  generateNaninasMarker(h_map);

  new google.maps.Marker({
    position: saddlebrook_lat_lng,
    map: h_map
  });

  bounds = new google.maps.LatLngBounds();

  bounds.extend(naninas_lat_lng);

  bounds.extend(saddlebrook_lat_lng);

  h_map.fitBounds(bounds);

  directions_service = new google.maps.DirectionsService();

  directions_service.route({
    destination: naninas_lat_lng,
    origin: saddlebrook_lat_lng,
    travelMode: google.maps.TravelMode.DRIVING
  }, function(directions) {
    return new google.maps.DirectionsRenderer({
      map: h_map,
      directions: directions
    });
  });

  $('#intro .slideshow').flexslider({
    animation: 'slide',
    useCSS: true
  });

  $('nav').on('click', 'a', function(e) {
    var aid, anchor;
    aid = $(this).attr('href').split('#')[1];
    anchor = $("a[name='" + aid + "']");
    $('html,body').animate({
      scrollTop: anchor.offset().top
    }, 'slow');
    return e.preventDefault();
  });

  window.scrollTo(0, 1);

}).call(this);
