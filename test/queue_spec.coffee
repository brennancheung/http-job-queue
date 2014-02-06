should = require('should')

MemoryQueue = require '../lib/queue/memory'
MongodbQueue = require '../lib/queue/mongodb'

describe 'queue', ->

  describe 'job execution', ->
    it 'execute script for job'
    it 'return result to queue'

  describe 'persistence strategy', ->

    queueInterfaceTests = (Queue) ->
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

    describe 'in memory', ->
      queueInterfaceTests(MemoryQueue)

    describe.skip 'MongoDB', ->
      queueInterfaceTests(MongodbQueue)
