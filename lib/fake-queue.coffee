sys          = require 'sys'
EventEmitter = require('events').EventEmitter
_            = require 'underscore'

rand = (max) -> Math.floor(Math.random() * max)

class ASE.FakeQueue extends EventEmitter
	
	constructor: (@server, @config) ->
		setTimeout _.bind(@sendFakeHit, this), rand(1000)
	
	sendFakeHit: ->
		@emit 'message',
			http:
				ipAddress: "#{rand(255)}.#{rand(255)}.#{rand(255)}.#{rand(255)}"
		setTimeout _.bind(@sendFakeHit, this), rand(1000)