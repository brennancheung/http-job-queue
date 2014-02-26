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
