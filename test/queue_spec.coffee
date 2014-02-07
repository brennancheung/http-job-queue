should = require('should')

MemoryQueue = require '../lib/queue/memory'
MongodbQueue = require '../lib/queue/mongodb'

fakeJob = (queue, status, payload, tags) ->
  job = queue.createJob(1, payload, tags)
  queue[status].push job

describe 'queue', ->

  describe 'job execution', ->
    it 'execute script for job'
    it 'return result to queue'

  describe 'persistence strategy', ->

    queueInterfaceTests = (Queue) ->
      it 'submit a job', ->
        queue = new Queue
        job = queue.submit 1, {foo: 'bar'}
        fetched = queue.fetch 1
        job.should.equal fetched

      it 'fetch next job atomically', ->
        queue = new Queue
        queue.submit 1, {foo: 'bar'}
        job = queue.fetch(1)
        job.should.be.ok
        job.payload.foo.should.equal.bar
        job.id.should.be.ok

      it 'fetch all jobs', ->
        queue = new Queue
        fakeJob queue, 'pending', {one: 1}
        fakeJob queue, 'pending', {two: 2}
        fakeJob queue, 'processing', {three: 3}
        fakeJob queue, 'done', {four: 4}
        fakeJob queue, 'failed', {five: 5}
        queue.fetchAll().length.should.equal 5

      it 'fetch pending jobs', ->
        queue = new Queue
        fakeJob queue, 'pending', {one: 1}
        queue.fetchPending().length.should.equal 1

      it 'fetch processing jobs', ->
        queue = new Queue
        fakeJob queue, 'processing', {one: 1}
        queue.fetchProcessing().length.should.equal 1

      it 'fetch done jobs', ->
        queue = new Queue
        fakeJob queue, 'done', {one: 1}
        queue.fetchDone().length.should.equal 1

      it 'fetch failed jobs', ->
        queue = new Queue
        fakeJob queue, 'failed', {one: 1}
        queue.fetchFailed().length.should.equal 1

      it 'clear a specific queue', ->
        queue = new Queue
        fakeJob queue, 'pending', {one: 1}
        fakeJob queue, 'pending', {two: 2}
        fakeJob queue, 'processing', {three: 3}
        fakeJob queue, 'done', {four: 4}
        fakeJob queue, 'failed', {five: 5}
        queue.clearQueue 'pending'
        queue.fetchPending().length.should.equal 0
        queue.fetchAll().length.should.equal 3

      it 'clear all jobs', ->
        queue = new Queue
        fakeJob queue, 'pending', {one: 1}
        fakeJob queue, 'pending', {two: 2}
        fakeJob queue, 'processing', {three: 3}
        fakeJob queue, 'done', {four: 4}
        fakeJob queue, 'failed', {five: 5}
        queue.clearAll()
        queue.fetchAll().length.should.equal 0

      describe 'publish / subscribe', ->
        it 'adding a subscriber', (done) ->
          queue = new Queue
          queue.subscribe 'submit', (event, job) ->
            done()
          queue.submit 1, {foo: 'bar'}

        it 'subscribe to a specific event or all', (done) ->
          queue = new Queue
          allCount = 0
          otherCount = 0
          testForCompletion = ->
            done() if allCount == 3 && otherCount == 2

          queue.subscribe 'all', (event, job) ->
            allCount++
            testForCompletion()

          queue.subscribe 'fetch', (event, job) ->
            otherCount++
            testForCompletion()

          queue.subscribe 'finish', (event, job) ->
            otherCount++
            testForCompletion()

          queue.submit 1, {foo: 'bar'}
          job = queue.fetch 1
          queue.finish job.id


    describe 'in memory', ->
      queueInterfaceTests(MemoryQueue)

    describe.skip 'MongoDB', ->
      queueInterfaceTests(MongodbQueue)
