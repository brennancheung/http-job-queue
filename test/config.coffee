Main = require('../lib/main')
should = require('should')
require 'mocha-sinon'

helpers = require './mocha_helpers'
stubArgv = helpers.stubArgv

describe 'configuration', ->
  it 'provide a reasonable default config', ->
    stubArgv @, '-L info'
    main = new Main()
    main.processConfig()
    main.config.port.should.equal 3000

  it 'allow command line arguments to override the config', ->
    stubArgv @, '-p 5555'
    main = new Main()
    main.processConfig()
    main.config.port.should.equal 5555

  it 'optional command line -c (--config) file'
  it 'optional /etc/http-job-queue/config.yml'
  it 'optional ~/.http-job-queue/config.yml'
  it 'process the configs in the proper order'
    # etc, home, specified config, command line
  it 'command line commands do not start a listener'
