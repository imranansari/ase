sys     = require 'sys'
express = require 'express'

class ASE.Server
	
	constructor: (@config) ->
		@app = express.createServer()
		@geolocator = new ASE.Geolocator(this, @config)
		@socket = new ASE.Socket(this, @config)
		
	run: ->
		@app.listen @config.server.port, =>
			addr = @app.address()
			sys.puts "[ase] listening on http://#{addr.address}:#{addr.port}"