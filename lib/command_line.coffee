program = require 'commander'
merge = require 'merge'

module.exports = ->
  config = {}

  # Unfortunately, commander is not re-entrant for testing purposes.  We need to flush out the fields each time.
  for option in 'configFile port logPath logLevel timeout'.split ' '
    program[option] = undefined

  program
    .option '-c, --config-file <path>', 'YAML config file'
    .option '-p, --port <n>',           'port to listen on', parseInt
    .option '-l, --log-path <path>',    'log file'
    .option '-L, --log-level <level>',  'log level (debug, info, warn, error)'
    .option '-t, --timeout <seconds>',  'amount of time a job can run before timing out', parseInt

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
    .parse process.argv

  for option in 'port configFile logPath logLevel timeout'.split(' ')
    config[option] = program[option] if program[option]

  return config

  # testing
