should = require('should')

Main = require('../lib/main')

describe 'queue', ->

  describe 'job execution', ->
    it 'execute script for job'
    it 'return result to queue'

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
