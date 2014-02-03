Main = require('../lib/main')
should = require('should')
commandLine = require '../lib/command_line'
require 'mocha-sinon'

helpers = require './mocha_helpers'
stubArgv = helpers.stubArgv

describe 'command line', ->

  describe 'options', ->
    it 'port: -p, --port', ->
      stubArgv @, '-p 3100'
      commandLine().port.should.equal 3100

      stubArgv @, '--port 4000'
      commandLine().port.should.equal 4000

    it 'config-file: -c, --config-file parameter', ->
      stubArgv @, '-c custom.yml'
      commandLine().configFile.should.equal 'custom.yml'

      stubArgv @, '--config-file custom-long.yml'
      commandLine().configFile.should.equal 'custom-long.yml'

    it 'log-path: -l, --log-path', ->
      stubArgv @, '-l log.txt'
      commandLine().logPath.should.equal 'log.txt'

      stubArgv @, '--log-path log-long.txt'
      commandLine().logPath.should.equal 'log-long.txt'

    it 'log-level: -L, --log-level', ->
      stubArgv @, '-L info'
      commandLine().logLevel.should.equal 'info'

      stubArgv @, '--log-level error'
      commandLine().logLevel.should.equal 'error'

    it 'timeout: -t, --timeout', ->
      stubArgv @, '-t 60'
      commandLine().timeout.should.equal 60

      stubArgv @, '--timeout 180'
      commandLine().timeout.should.equal 180

  describe 'mixing', ->
    it 'allow multiple command line options', ->
      stubArgv @, '-p 8888 -L error'
      config = commandLine()
      config.port.should.equal 8888
      config.logLevel.should.equal 'error'

    it 'allow commands and command line options to be combined', ->
      stubArgv @, '-p 1234 -L warn all'
      config = commandLine()
      config.port.should.equal 1234
      config.logLevel.should.equal 'warn'
      config.command.should.equal 'all'
