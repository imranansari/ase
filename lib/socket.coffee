io = require 'socket.io'

class ASE.Socket
	
	constructor: (@server, @config) ->
		@io = io.listen @server.app
		@io.on 'connection', (socket) =>
			socket.json.send
				connections: @io.sockets.length
	
	broadcast: (data) ->
		@io.sockets.json.send data