fs = require 'fs'

module.exports =
  argv: (context, str) ->
    # mocha-sinon normally is called like @sinon.stub but since we are not within
    # a 'describe', or 'it', we need to pass in the context
    args = ['coffee', 'http-job-queue']
    args = args.concat str.split(' ') if str
    context.sinon.stub process, 'argv', args

  readFile: (context, file, contents) ->
    originalReadFile = fs.readFile
    originalExists = fs.exists

    context.sinon.stub fs, 'readFile', (filename, encoding, callback) ->
      if filename == file
        callback(null, contents)
      else
        # not sure if this actually works, I haven't had a need to use this branch yet
        originalReadFile filename, encoding, callback

    # Sometimes code checks to see if a file exists before attempting to read so we
    # need to stub fs.exists too.
    context.sinon.stub fs, 'exists', (filename, callback) ->
      if filename == file
        callback(true)
      else
        originalExists filename, callback
