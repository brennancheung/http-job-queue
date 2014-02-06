Auth = require '../lib/auth'

should = require 'should'
sinon = require 'sinon'

describe 'authentication', ->
  before ->
    @auth = new Auth 'secret'

  it 'should use sha256 with Base64 encoding', ->
    @auth.sha256('the value').should.equal 'i5DEx5GcSFxjCxqKbcpZ7otJQeSXHwPvti2dFlgRQ/8='

  it 'should use the userId and current UTC epoch timestamp to generate a signature', ->
    @auth.signature(1, 12345).should.equal '1 12345'

  it 'should verify the auth token', ->
    clock = sinon.useFakeTimers 12345
    (new Date).getTime().should.equal 12345
    @auth.validateAuth(1, 12345, 'kkXAoojHv1qgsjypt91FEvIxZE2nt2WVVebj5sbHGGQ=').should.be.true
    clock.restore()

  it 'should have a grace period with the timer', ->
    clock = sinon.useFakeTimers 12345 + 900
    @auth.validateAuth(1, 12345, 'kkXAoojHv1qgsjypt91FEvIxZE2nt2WVVebj5sbHGGQ=').should.be.true
    clock.restore()

  it 'should fail auth after the grace period', ->
    clock = sinon.useFakeTimers 12345 + 901
    @auth.validateAuth(1, 12345, 'kkXAoojHv1qgsjypt91FEvIxZE2nt2WVVebj5sbHGGQ=').should.be.false
    clock.restore()
