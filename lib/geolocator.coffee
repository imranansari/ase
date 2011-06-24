geoip = require 'geoip'

class ASE.Geolocator
	
	constructor: (@server, @config) ->
		@geodb = new geoip.City @config.geoip.db
	
	lookup: (value, callback) ->
		@geodb.lookup value, callback