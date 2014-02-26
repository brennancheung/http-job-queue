http-job-queue
=============

A simple job queue that is exposed from an HTTP API.
Queues can be specified through various strategies.
The in-memory store is mostly done and a persistent version through MongoDB is planned.

Jobs mechanism has not been implemented yet.
I'm hoping to add script execution, spawn functionality, and capturing STDOUT and STDERR.

Motivation
---
This is a small project that will help me learn node and its ecosystem.

Using
---

    git clone https://github.com/brennancheung/http-job-queue.git
    cd http-job-queue/
    npm install -g coffee-script
    npm install -g mocha
    npm install
    npm test

    ./http-job-queue -h

      Usage: http-job-queue [options] [command]

      Commands:

        all                    show all jobs (pending, processing, done, failed)
        pending                show all pending jobs
        processing             show all processing jobs
        done                   show all done jobs
        failed                 show all failed jobs
        realtime               show jobs in realtime

      Options:

        -h, --help                   output usage information
        -c, --config-file <path>     YAML config file
        -p, --port <n>               port to listen on
        -l, --log-path <path>        log file
        -L, --log-level <level>      log level (debug, info, warn, error)
        -t, --timeout <seconds>      amount of time a job can run before timing out
        -s, --strategy <type>        strategy for persistence
        -x, --execute-script <path>  script for processing a job
