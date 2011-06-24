exports.config =

	server:
		debug:    true
		port:     3000
	
	queue:
		host:     'localhost'
		exchange: 'zen.logging'
	
	geoip:
		db:       'data/GeoLiteCity.dat'