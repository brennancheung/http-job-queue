http = require('http')
server = require('../lib/server')
should = require('should')

delay = (ms, fn) -> setTimeout fn, ms

assertRequest = (url, params) ->
  data = ''
  http.get url, (res) ->
    res.on 'data', (chunk) -> data += chunk
    res.on 'end', ->
      res.statusCode.should.equal params.statusCode if params.statusCode
      data.should.equal params.contents if params.contents

describe 'everything', ->
  before ->
    server.config 3100
    server.start()

  after ->
    server.stop()

  describe 'server related stuff', ->
    it 'should return 200', ->
      assertRequest 'http://localhost:3100',
        statusCode: 200

    it 'should say hello', ->
      assertRequest 'http://localhost:3100',
        contents: 'Hello World'

    it 'should be able to combine assertRequest conditions', ->
      assertRequest 'http://localhost:3100',
        contents: 'Hello World'
        statusCode: 200

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
