should = require('should')
fs = require 'fs'
yaml = require 'js-yaml'

Main = require('../lib/main')

describe 'configuration', ->
  it 'provide a reasonable default config', (done) ->
    main = new Main
    main.processCommandLine()
    main.processConfig (err, config) ->
      config.port.should.equal 3000
      done()

  it 'allow command line arguments to override the config', (done) ->
    main = new Main
    main.processCommandLine()
    main.commandLineConfig.port = 5555
    main.processConfig (err, config) ->
      config.port.should.equal 5555
      done()

  describe 'loading config files', ->
    it 'valid yaml file', (done) ->
      main = new Main
      main.processCommandLine()
      main.commandLineConfig.configFile = __dirname + '/fixtures/config.yml'
      main.processConfig (err, config) ->
        config.port.should.equal 5555
        config.timeout.should.equal 1234
        done()

    it 'invalid file contents'
      # throw an error

    it 'missing file'
      # just return null, using a 'merge' with null is basically a NOP

  it 'process the configs in the proper order'
    # etc, home, specified config, command line
  it 'command line commands do not start a listener'
