(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  window.ASE = {};
  ASE.Client = (function() {
    function Client() {
      this.map = new google.maps.Map($('#map-container')[0], {
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.HYBRID
      });
      this.markers = [];
      navigator.geolocation.getCurrentPosition(__bind(function(pos) {
        return this.map.setCenter(new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
      }, this));
    }
    Client.prototype.run = function() {
      this.socket = io.connect('http://localhost:3000/');
      return this.socket.on('connect', __bind(function() {
        return this.socket.on('message', _.bind(this.addMarker, this));
      }, this));
    };
    Client.prototype.addMarker = function(hit) {
      return this.markers.push(new google.maps.Marker({
        map: this.map,
        animation: google.maps.Animation.DROP,
        position: new google.maps.LatLng(hit.latitude, hit.longitude)
      }));
    };
    return Client;
  })();
}).call(this);
