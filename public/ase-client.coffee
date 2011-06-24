window.ASE = {}

class ASE.Client
	
	constructor: ->
		
		@map = new google.maps.Map $('#map-container')[0],
			zoom:      5,
			mapTypeId: google.maps.MapTypeId.HYBRID
		
		@markers = []

		navigator.geolocation.getCurrentPosition (pos) =>
			@map.setCenter new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude)
			
	run: ->
		@socket = io.connect 'http://localhost:3000/'
		@socket.on 'connect', =>
			@socket.on 'message', _.bind(@addMarker, this)
			
	addMarker: (hit) ->
		@markers.push new google.maps.Marker
			map: @map
			animation: google.maps.Animation.DROP
			position: new google.maps.LatLng(hit.latitude, hit.longitude)