http = require('http')

class Server
  constructor: (params) ->
    params ||= {}
    @port = params.port || 3000
    @server = http.createServer params.router || @router

  start: () ->
    @server.listen(@port)

  stop: () ->
    @server.close()

  router: (req, res) ->
    res.writeHead 200, {'Content-Type': 'text/html'}
    res.end 'Hello World'

module.exports = Server
