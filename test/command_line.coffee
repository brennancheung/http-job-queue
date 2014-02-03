should = require('should')
mochaSinon = require 'mocha-sinon'

Main = require('../lib/main')
commandLine = require '../lib/command_line'

stubs = require './helpers/stubs'

describe 'command line', ->

  describe 'options', ->
    it 'port: -p, --port', ->
      stubs.argv @, '-p 3100'
      commandLine().port.should.equal 3100

      stubs.argv @, '--port 4000'
      commandLine().port.should.equal 4000

    it 'config-file: -c, --config-file parameter', ->
      stubs.argv @, '-c custom.yml'
      commandLine().configFile.should.equal 'custom.yml'

      stubs.argv @, '--config-file custom-long.yml'
      commandLine().configFile.should.equal 'custom-long.yml'

    it 'log-path: -l, --log-path', ->
      stubs.argv @, '-l log.txt'
      commandLine().logPath.should.equal 'log.txt'

      stubs.argv @, '--log-path log-long.txt'
      commandLine().logPath.should.equal 'log-long.txt'

    it 'log-level: -L, --log-level', ->
      stubs.argv @, '-L info'
      commandLine().logLevel.should.equal 'info'

      stubs.argv @, '--log-level error'
      commandLine().logLevel.should.equal 'error'

    it 'timeout: -t, --timeout', ->
      stubs.argv @, '-t 60'
      commandLine().timeout.should.equal 60

      stubs.argv @, '--timeout 180'
      commandLine().timeout.should.equal 180

  describe 'mixing', ->
    it 'allow multiple command line options', ->
      stubs.argv @, '-p 8888 -L error'
      config = commandLine()
      config.port.should.equal 8888
      config.logLevel.should.equal 'error'

    it 'allow commands and command line options to be combined', ->
      stubs.argv @, '-p 1234 -L warn all'
      config = commandLine()
      config.port.should.equal 1234
      config.logLevel.should.equal 'warn'
      config.command.should.equal 'all'
