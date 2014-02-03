commandLine = require './command_line'
merge = require 'merge'

class Main
  constructor: ->
    @serverMode = true
    @commandLineConfig = commandLine()

  processConfig: ->
    # generate the config hash
    defaultConfig =
      port: 3000
      log: false

    @config = merge defaultConfig, @etcConfig, @homeConfig, @commandLineConfig

  processCommand: ->
    # commands don't start up a listener server
    @serverMode = false

    # commands need the config information present before they can proceed
    processConfig() unless @config

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

    commands[@config.command] if @config.command

  startServer: ->
    if @serverMode
      console.log "Starting server"

module.exports = Main
