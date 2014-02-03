fs = require 'fs'

module.exports =
  argv: (context, str) ->
    # mocha-sinon normally is called like @sinon.stub but since we are not within
    # a 'describe', or 'it', we need to pass in the context
    args = ['env', 'http-job-queue']
    args = args.concat str.split(' ') if str
    context.sinon.stub process, 'argv', args

  readFile: (context, contents) ->
    context.sinon.stub fs, 'readFile', (filename, encoding, callback) -> callback(null, contents)
