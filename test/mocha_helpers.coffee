stubArgv = (context, str) =>
  # mocha-sinon normall is called like @sinon.stub but since we are not within
  # a 'describe', or 'it', we need to pass in the context
  args = ['env', 'http-job-queue']
  args = args.concat str.split(' ') if str
  context.sinon.stub process, 'argv', args

module.exports =
  stubArgv: stubArgv
