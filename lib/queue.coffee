sys          = require 'sys'
amqp         = require 'amqp'
EventEmitter = require('events').EventEmitter

class ASE.Queue extends EventEmitter
	
	constructor: (@server, @config) ->
		
		host = @config.queue.host ? 'localhost'
		exchange = @config.queue.exchange ? 'amqp.topic'
		
		@conn = amqp.createConnection
			host: host
		
		@conn.on 'ready', =>
			@conn.queue "ase-#{process.pid}",
				exclusive: true,
				(queue) =>
					
					queue.on 'open', =>
						sys.puts "[ase] connected to queue server on #{host}"
					
					queue.subscribe (message, headers, deliveryInfo) =>
						@emit 'message', message
						
					@conn.exchange exchange,
						passive: true,
						(ex) =>
							queue.bind ex, '#'
							sys.puts "[ase] queue bound to #{exchange} exchange"	
