should = require('should')

Main = require('../lib/main')

describe 'feature wishlist', ->
  describe 'REPL', ->
    it 'JavaScript'
    it 'CoffeeScript'
  describe 'script execution', ->
    it 'Javascript'
    it 'CoffeeScript'
    it 'execute script from command line'
  describe 'refactor stubs', ->
    # mocha-sinon is messy and has a bug when running mocha in watch mode
    it 'support for https://github.com/elliotf/mocha-sinon/issues/1'
    it 'provide mechanism for easy sandboxing (beforeEach -> stubs = new Stubs ; afterEach -> stubs.restore()'
    it 'clear commander cache, http://stuffpetedoes.blogspot.com/2012/07/grunt-watch-and-nodejs-require-cache.html'
