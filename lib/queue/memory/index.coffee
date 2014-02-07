uuid = require 'node-uuid'

class Queue
  constructor: ->
    @pending = []
    @processing = []
    @done = []
    @failed = []
    @journal = []
    @subscribers = []

  createJob: (userId, payload, tags) ->
    job =
      id: uuid.v4()
      userId: userId
      payload: payload
      submitted: (new Date).getTime()
      status: 'pending'
      tags: tags || []

  addToQueue: (queue, job) ->
    @[queue].push job

  submit: (userId, payload, tags) ->
    job = @createJob userId, payload, tags
    @publish 'submit', job
    @addToQueue 'pending', job
    return job

  fetch: (userId, tags) ->
    # move the job from @pending to @processing
    for job, idx in @pending when job.userId == userId
      removed = @pending.splice(idx, 1)[0]
      @addToQueue 'processing', removed
      @publish 'fetch', removed
      return removed

  finish: (jobId) ->
    # move the job from @processing to @done
    for job, idx in @processing when job.id == jobId
      removed = @processing.splice(idx, 1)[0]
      @addToQueue 'done', removed
      @publish 'finish', removed
      return removed

  fail: (jobId) ->
    # move the job from @processing to @failed
    for job, idx in @processing when job.id == jobId
      removed = @processing.splice(idx, 1)[0]
      @addToQueue 'failed', removed
      @publish 'fail', removed
      return removed

  subscribe: (action, callback) ->
    subscriber =
      id: uuid.v4()
      action: action
      callback: callback
    @subscribers.push subscriber

  unsubscribe: (id) ->
    for subscriber, idx in @subscribers when subscriber.id == id
      removed = @subscribers.splice(idx, 1)[0]
      return true
    return false

  publish: (action, job) ->
    event =
      action: action
      ts: (new Date).getTime()
      job: job
    @journal.push event
    for subscriber in @subscribers when subscriber.action == action || subscriber.action == 'all'
      subscriber.callback(job)

  countAll: ->
    total = 0
    total += @pending.length
    total += @processing.length
    total += @done.length
    total += @failed.length

  clearQueue: (queue) ->
    @[queue] = []

  clearAll: ->
    @clearQueue 'pending'
    @clearQueue 'processing'
    @clearQueue 'done'
    @clearQueue 'failed'

  fetchPending:    -> @pending
  fetchProcessing: -> @processing
  fetchDone:       -> @done
  fetchFailed:     -> @failed
  fetchAll:        -> @pending.concat(@processing).concat(@done).concat(@failed)

  countPending:    -> @pending.length
  countProcessing: -> @processing.length
  countDone: ->       @done.length
  countFailed: ->     @failed.length

module.exports = Queue
