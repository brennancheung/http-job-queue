http = require('http')

class Server
  constructor: (params) ->
    params ||= {}
    @port = params.port || 3000
    @requestHandler = params.requestHandler || (req, res) ->
      res.writeHead 200, {'Content-Type': 'text/html'}
      res.end 'Hello World'
    @server = http.createServer @requestHandler

  start: () ->
    @server.listen(@port)

  stop: () ->
    @server.close()

module.exports = Server
