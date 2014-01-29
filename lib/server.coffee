http = require('http')

@server = http.createServer (req, res) ->
  res.writeHead 200, {'Content-Type': 'text/html'}
  res.write 'Hello World'
  res.end()

@port = 3000
@config = {}

exports.config = (port, config) ->
  @port = port if port
  @config = config if config

exports.start = ->
  # console.log "starting the server on port #{@port}"
  @server.listen(@port)

exports.stop = ->
  @server.close()
