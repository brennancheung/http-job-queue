commandLine = require './command_line'
merge = require 'merge'
yaml = require 'js-yaml'
fs = require 'fs'

class Main
  constructor: ->
    @serverMode = true

  loadYamlFile: (filename, next) ->
    fs.readFile filename, 'utf-8', (err, data) ->
      return next(err, null) if err
      try
        conf = yaml.load data
        next(null, conf)
      catch exception
        next(exception, null)


  loadConfigFile: (filepath, next) ->
    self = @
    return next(null, null) unless filepath
    fs.exists filepath, (exists) ->
      return next(null, null) unless exists
      self.loadYamlFile filepath, next

  processCommandLine: (override) ->
    @commandLineConfig = commandLine(override)

  processConfig: (next) ->
    defaultConfig =
      port: 3000
      log: false
      strategy: 'memory'

    commandLineConfigFile = @commandLineConfig.configFile

    @loadConfigFile commandLineConfigFile, (err, configFromFile) =>
      return next(err, null) if err
      @config = merge defaultConfig, configFromFile, @commandLineConfig

      # error if they use an invalid strategy
      unless @config.strategy in ['memory', 'mongodb']
        @serverMode = false
        @config.command = undefined
        throw 'invalid strategy'

      next(null, @config)

  processCommand: ->
    if @config.command
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
