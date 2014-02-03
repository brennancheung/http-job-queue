should = require('should')
mochaSinon = require 'mocha-sinon'
fs = require 'fs'
yaml = require 'js-yaml'

Main = require('../lib/main')

stubs = require './helpers/stubs'

describe 'main', ->

