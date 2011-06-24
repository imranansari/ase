sys     = require 'sys'
express = require 'express'
_       = require 'underscore'

class ASE.Server
	
	constructor: (@config, fake = false) ->
		
		publicdir = @config.server.public ? 'public'
		
		@app = express.createServer()
		
		@app.use express.compiler
			src: publicdir
			enable: [ 'coffeescript' ]
			
		@app.use express.static(publicdir)
		
		@geolocator = new ASE.Geolocator(this, @config)
		@socket     = new ASE.Socket(this, @config)
		@queue      = if ASE.fake? then new ASE.FakeQueue(this, @config) else new ASE.Queue(this, @config)
		
	run: ->
		
		@app.listen @config.server.port, =>
			addr = @app.address()
			sys.puts "[ase] listening on http://#{addr.address}:#{addr.port}"
		
		@queue.on 'message', _.bind(@handleMessage, this)
	
	handleMessage: (message) ->
		addr = message?.http?.ipAddress
		if addr?
			@geolocator.lookup addr, (err, result) =>
				if err?
					console.log "[ase] geolocation error: #{err.message}"
				else
					@socket.broadcast
						latitude:  result.latitude
						longitude: result.longitude