htmlate = require('../lib/server')
should = require('should')

delay = (ms, fn) -> setTimeout fn, ms

describe 'configuration', ->
  it 'should provide a reasonable default config', ->
  it 'should take an optional command line -c (--config) file', ->

describe 'jobs', ->
  it 'should accept jobs from HTTP', ->
  it 'should deliver jobs to requesters', ->

describe 'error conditions', ->
  it 'should detect jobs that take too long', ->
  it 'should detect jobs that error out', ->
  it 'should kill jobs that time out', ->
  it 'should send a notification for timeouts', ->
  it 'should send a notification for jobs that error out', ->
