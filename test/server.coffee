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

describe 'server customization', ->
  it 'should allow server to be started', (done) ->
    server = new Server(port: 3100)
    server.start()
    assertRequest 'http://localhost:3100', {contents: 'Hello World', statusCode: 200}, ->
      server.stop()
      done()

  it 'should allow server the request handler to be injected', (done) ->
    server = new Server
      port: 3100
      requestHandler: (req, res) ->
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

  describe 'configuration', ->
    it 'should provide a reasonable default config'
    it 'should take an optional command line -c (--config) file'

  describe 'jobs', ->
    it 'should accept jobs from HTTP'
    it 'should deliver jobs to requesters'

  describe 'error conditions', ->
    it 'should detect jobs that take too long'
    it 'should detect jobs that error out'
    it 'should kill jobs that time out'
    it 'should send a notification for timeouts'
    it 'should send a notification for jobs that error out'
