commandLine = require './command_line'
merge = require 'merge'
yaml = require 'js-yaml'
fs = require 'fs'
async = require 'async'

class Main
  constructor: ->
    @serverMode = true

  loadYamlFile: (filename, next) ->
    fs.readFile filename, 'utf-8', (err, data) ->
      return next(err, null) if err
      conf = yaml.load data
      next(null, conf)

  loadConfigFile: (filepath, next) ->
    self = @
    return next(null, null) unless filepath
    fs.exists filepath, (exists) ->
      return next(null, null) unless exists
      self.loadYamlFile filepath, next

  processCommandLine: ->
    @commandLineConfig = commandLine()

  processConfig: (next) ->
    defaultConfig =
      port: 3000
      log: false

    commandLineConfigFile = @commandLineConfig.configFile

    @loadConfigFile commandLineConfigFile, (err, configFromFile) =>
      return next(err, null) if err
      @config = merge defaultConfig, configFromFile, @commandLineConfig
      next(null, @config)

  processCommand: ->
    # commands don't start up a listener server
    @serverMode = false

    commands =
      all:  ->
        console.log 'TODO: show all jobs'
      pending: ->
        console.log 'TODO: show all pending jobs'
      processing: ->
        console.log 'TODO: show all processing jobs'
      done: ->
        console.log 'TODO: show all done jobs'
      failed: ->
        console.log 'TODO: show all failed jobs'
      realtime: ->
        console.log 'TODO: show jobs in realtime'

    commands[@config.command]() if @config.command

  startServer: ->
    if @serverMode
      console.log "Starting server"

module.exports = Main
