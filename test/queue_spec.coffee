should = require('should')

Queue = require '../lib/queue/memory'

describe 'queue', ->

  describe 'job execution', ->
    it 'execute script for job'
    it 'return result to queue'

  describe 'persistence strategy', ->

    describe 'in memory', ->
      it 'submit a job', ->
        queue = new Queue
        queue.submit 1, {foo: 'bar'}
        queue.pending.length.should.equal == 1
        queue.pending[0].payload.foo.should.equal 'bar'

      it 'fetch next job atomically', ->
        queue = new Queue
        queue.submit 1, {foo: 'bar'}
        job = queue.fetch(1)
        job.should.be.ok
        job.payload.foo.should.equal.bar
        job.id.should.be.ok

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
