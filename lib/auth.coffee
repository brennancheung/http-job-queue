crypto = require 'crypto'

class Auth
  constructor: (secret) ->
    @secret = secret

  sha256: (value) ->
    hmac = crypto.createHmac 'sha256', @secret
    hmac.update value
    hmac.digest 'base64'

  signature: (userId, epoch) ->
    # epoch should be the epoch time in UTC as an integer
    "#{userId} #{epoch}"

  authToken: (userId, epoch) ->
    @sha256 @signature(userId, epoch)

  validateAuth: (userId, epoch, theirToken) ->
    now = new Date().getTime()
    return false if now - epoch > 900
    correctToken = @authToken(userId, epoch)
    correctToken == theirToken

module.exports = Auth
