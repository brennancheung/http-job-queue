program = require 'commander'
merge = require 'merge'

module.exports = (override) ->
  options = process.argv

  # allow dependency injection for easier testing
  if override
    args = ['coffee', 'http-job-queue']
    # add 2 entries in the front to make it look like it came from process.argv
    options = args.concat override.split(' ') if override.length > 0

  config = {}

  possibleOptions = 'configFile port logPath logLevel timeout executeScript strategy'.split ' '

  # Unfortunately, commander is not re-entrant for testing purposes.  We need to flush out the fields each time.
  for option in possibleOptions
    program[option] = undefined

  program
    .option '-c, --config-file <path>', 'YAML config file'
    .option '-p, --port <n>',           'port to listen on', parseInt
    .option '-l, --log-path <path>',    'log file'
    .option '-L, --log-level <level>',  'log level (debug, info, warn, error)'
    .option '-t, --timeout <seconds>',  'amount of time a job can run before timing out', parseInt
    .option '-s, --strategy <type>',    'strategy for persistence'
    .option '-x, --execute-script <path>',  'script for processing a job'

  program
    .command 'all'
    .description 'show all jobs (pending, processing, done, failed)'
    .action -> config.command = 'all'

  program
    .command 'pending'
    .description 'show all pending jobs'
    .action -> config.command = 'pending'

  program
    .command 'processing'
    .description 'show all processing jobs'
    .action -> config.command = 'processing'

  program
    .command 'done'
    .description 'show all done jobs'
    .action -> config.command = 'done'

  program
    .command 'failed'
    .description 'show all failed jobs'
    .action -> config.command = 'failed'

  program
    .command 'realtime'
    .description 'show jobs in realtime'
    .action -> config.command = 'realtime'

  program
    .parse options

  for option in possibleOptions
    config[option] = program[option] if program[option]

  return config
