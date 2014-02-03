Main = require('../lib/main')
should = require('should')
commandLine = require '../lib/command_line'
require 'mocha-sinon'

helpers = require './mocha_helpers'
stubArgv = helpers.stubArgv

describe 'commands', ->
  it 'all: show all jobs'
  it 'pending: show pending jobs'
  it 'processing: show processing jobs'
  it 'done: show done jobs'
  it 'failed: show failed jobs'
  it 'realtime: show jobs in realtime'
