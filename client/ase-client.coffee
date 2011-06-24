window.ASE = {}

class ASE.Client
	
	run: ->
		@socket = io.connect('http://localhost:3000/')
		@socket.on 'connect', =>
			@socket.on 'message', (message) =>
				$('body').append(message)