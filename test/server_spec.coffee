http = require('http')
Server = require('../lib/server')
should = require('should')

delay = (ms, fn) -> setTimeout fn, ms

assertRequest = (url, params, done) ->
  data = ''
  http.get url, (res) ->
    res.on 'data', (chunk) -> data += chunk
    res.on 'end', ->
      res.statusCode.should.equal params.statusCode if params.statusCode
      data.should.equal params.contents if params.contents
      done() if done

describe 'server', ->
  describe 'customization', ->
    # I'll probably get rid of these later.  Just for incremental development right now.
    it 'starting the server', (done) ->
      server = new Server(port: 3100)
      server.start()
      assertRequest 'http://localhost:3100', {contents: 'Hello World', statusCode: 200}, ->
        server.stop()
        done()

    it 'routerr injection', (done) ->
      server = new Server
        port: 3100
        router: (req, res) ->
          res.writeHead 200, {'Content-Type': 'text/html'}
          res.end 'injected'
      server.start()
      assertRequest 'http://localhost:3100',
        contents: 'injected'
        statusCode: 200
        , () ->
          server.stop()
          done()

  describe 'default server', ->
    before ->
      @server = new Server(port: 3100)
      @server.start()

    after ->
      @server.stop()

    describe 'server related stuff', (done) ->
      it 'should return 200', ->
        assertRequest 'http://localhost:3100', {statusCode: 200}, done

      it 'should say hello', (done) ->
        assertRequest 'http://localhost:3100', {contents: 'Hello World'}, done

      it 'should be able to combine assertRequest conditions', (done) ->
        assertRequest 'http://localhost:3100', {contents: 'Hello World', statusCode: 200}, done

    describe 'authentication', ->
      it 'requests should be authenticated'

    describe 'jobs', ->
      it 'accept jobs from HTTP'
      it 'deliver jobs to requesters'

    describe 'error conditions', ->
      it 'detect jobs that take too long'
      it 'detect jobs that error out'
      it 'kill jobs that time out'
      it 'send a notification for timeouts'
      it 'send a notification for jobs that error out'
