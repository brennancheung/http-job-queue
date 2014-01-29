http = require('http')
server = require('../lib/server')
should = require('should')

delay = (ms, fn) -> setTimeout fn, ms

describe 'everything', ->
  before ->
    server.config 3100
    server.start()

  after ->
    server.stop()

  describe 'server related stuff', ->
    it 'should return 200', ->
      http.get 'http://localhost:3100', (res) ->
        res.statusCode.should.equal 200

    it 'should say hello', ->
      data = ''
      http.get 'http://localhost:3100', (res) ->
        res.on 'data', (chunk) -> data += chunk
        res.on 'end', ->
          data.should.equal 'Hello World'


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
