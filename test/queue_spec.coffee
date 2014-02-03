should = require('should')
mochaSinon = require 'mocha-sinon'

Main = require('../lib/main')
stubs = require './helpers/stubs'

describe 'queue', ->
  describe 'persistence strategy', ->
    describe 'in memory', ->
      it 'submit a job'
      it 'fetch next job atomically'
      it 'fetch all jobs'
      it 'fetch pending jobs'
      it 'fetch processing jobs'
      it 'fetch done jobs'
      it 'fetch failed jobs'
      it 'stream jobs as they change'
      it 'clear a specific queue'
      it 'clear all jobs'
    describe 'MongoDB', ->
      it 'submit a job'
      it 'fetch next job atomically'
      it 'fetch all jobs'
      it 'fetch pending jobs'
      it 'fetch processing jobs'
      it 'fetch done jobs'
      it 'fetch failed jobs'
      it 'stream jobs as they change'
      it 'clear a specific queue'
      it 'clear all jobs'
