should = require('should')
mochaSinon = require 'mocha-sinon'
fs = require 'fs'
yaml = require 'js-yaml'

Main = require('../lib/main')

stubs = require './helpers/stubs'

describe 'configuration', ->
  it 'provide a reasonable default config', ->
    stubs.argv @
    main = new Main
    main.config.port.should.equal 3000

  it 'allow command line arguments to override the config', ->
    stubs.argv @, '-p 5555'
    main = new Main()
    main.config.port.should.equal 5555

  describe 'loading config files', ->
    it 'valid yaml file', (done) ->
      conf =
        port: 5000
        logLevel: 'error'
        timeout: 123

      confAsYaml = yaml.dump(conf)
      stubs.readFile @, confAsYaml

      (new Main).loadYamlFile 'custom-conf.yml', (loadedConfig) ->
        loadedConfig.should.eql conf
        (fs.readFile.calledWith 'custom-conf.yml').should.be.true
        done()

    it 'invalid file contents'
      # throw an error

    it 'missing file'
      # just return null, using a 'merge' with null is basically a NOP

  it 'optional /etc/http-job-queue/config.yml'
  it 'optional ~/.http-job-queue/config.yml'
  it 'process the configs in the proper order'
    # etc, home, specified config, command line
  it 'command line commands do not start a listener'
