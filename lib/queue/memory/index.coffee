uuid = require 'node-uuid'

class Queue
  constructor: ->
    @pending = []
    @processing = []
    @done = []
    @failed = []
    @journal = []

  submit: (userId, payload, tags) ->
    job =
      id: uuid.v4()
      userId: userId
      payload: payload
      submitted: (new Date).getTime()
      status: 'pending'
      tags: tags || []

    @log 'submit', job
    @pending.push job
    return @job

  fetch: (userId, tags) ->
    # move the job from @pending to @processing
    for job, idx in @pending when job.userId == userId
      removed = @pending.splice(idx, 1)[0]
      @processing.push removed
      @log 'fetch', removed
      return removed

  finish: (jobId) ->
    # move the job from @processing to @done
    for job, idx in @processing when job.id == jobId
      removed = @processing.splice(idx, 1)[0]
      @done.push removed
      @log 'finish', removed
      return removed

  fail: (jobId) ->
    # move the job from @processing to @failed
    for job, idx in @processing when job.id == jobId
      removed = @processing.splice(idx, 1)[0]
      @failed.push removed
      @log 'fail', removed
      return removed

  log: (action, job) ->
    @journal.push
      action: action
      ts: (new Date).getTime()
      job: job

  countAll: ->
    total = 0
    total += @pending.length
    total += @processing.length
    total += @done.length
    total += @failed.length

  fetchPending:    -> @pending
  fetchProcessing: -> @processing
  fetchDone:       -> @done
  fetchFailed:     -> @failed
  fetchAll:        -> @pending.concat(@processing).concat(@done).concat(@failed)

  streamPending:    (callback) -> callback(job) for job in @pending
  streamProcessing: (callback) -> callback(job) for job in @processing
  streamDone:       (callback) -> callback(job) for job in @done
  streamFailed:     (callback) -> callback(job) for job in @failed

  countPending:    -> @pending.length
  countProcessing: -> @processing.length
  countDone: ->       @done.length
  countFailed: ->     @failed.length

module.exports = Queue
