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

    it 'invalid file contents', (done) ->
      main = new Main
      main.loadConfigFile __dirname + '/fixtures/invalid-yaml.txt', (err, conf) ->
        (err  == null).should.be.false
        (conf == null).should.be.true
        done()

    it 'missing file', (done) ->
      main = new Main
      main.loadConfigFile __dirname + '/fixtures/does-not-exist.yml', (err, conf) ->
        (conf == null).should.be.true
        done()

  it 'start listener if command not present', ->
    main = new Main
    main.processCommandLine()
    main.processConfig (err, config) ->
      main.processCommand()
      main.serverMode.should.be.true

  it 'command line commands do not start a listener', ->
    main = new Main
    main.serverMode.should.be.true
    main.processCommandLine 'all -p 4444'
    main.processConfig (err, config) ->
      config.port.should.equal 4444
      main.processCommand()
      main.serverMode.should.be.false

  describe 'choosing persistence strategy', ->
    it 'default to "memory" strategy', (done) ->
      main = new Main
      main.processCommandLine()
      main.processConfig (err, config) ->
        config.strategy.should.equal 'memory'
        done()

    it 'only accept valid strategies', (done) ->
      main = new Main
      main.processCommandLine()
      main.commandLineConfig.strategy = 'not a strategy'
      try
        main.processConfig()
      catch exception
        exception.should.match /invalid strategy/
        done()

    it 'set persistence strategy from the config file', (done) ->
      main = new Main
      main.processCommandLine '-c ' + __dirname + '/fixtures/persistence.yml'
      main.processConfig (err, config) ->
        config.strategy.should.equal 'mongodb'
        done()

    it 'set additional presistence parameters', (done) ->
      main = new Main
      main.processCommandLine '-c ' + __dirname + '/fixtures/persistence.yml'
      main.processConfig (err, config) ->
        config.mongodb.port.should.equal 27017
        config.mongodb.database.should.equal 'jobs'
        done()
