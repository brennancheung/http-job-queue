should = require('should')

Main = require('../lib/main')
commandLine = require '../lib/command_line'

describe 'command line', ->

  describe 'options', ->
    it 'port: -p, --port', ->
      commandLine('-p 3100').port.should.equal 3100

      commandLine('--port 4000').port.should.equal 4000

    it 'config-file: -c, --config-file parameter', ->
      commandLine('-c custom.yml').configFile.should.equal 'custom.yml'

      commandLine('--config-file custom-long.yml').configFile.should.equal 'custom-long.yml'

    it 'log-path: -l, --log-path', ->
      commandLine('-l log.txt').logPath.should.equal 'log.txt'

      commandLine('--log-path log-long.txt').logPath.should.equal 'log-long.txt'

    it 'log-level: -L, --log-level', ->
      commandLine('-L info').logLevel.should.equal 'info'

      commandLine('--log-level error').logLevel.should.equal 'error'

    it 'timeout: -t, --timeout', ->
      commandLine('-t 60').timeout.should.equal 60

      commandLine('--timeout 180').timeout.should.equal 180

  describe 'mixing', ->
    it 'allow multiple command line options', ->
      config = commandLine('-p 8888 -L error')
      config.port.should.equal 8888
      config.logLevel.should.equal 'error'

    it 'allow commands and command line options to be combined', ->
      config = commandLine('-p 1234 -L warn all')
      config.port.should.equal 1234
      config.logLevel.should.equal 'warn'
      config.command.should.equal 'all'
