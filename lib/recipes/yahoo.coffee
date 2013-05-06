request = require "request"
creds = (require __dirname+"/../../config/creds").yahoo

onStandings = (e, r, body) ->
  console.log "e: ", e if e?
  console.log "standings: ", body

getStats = ->

  opts = 
    uri: "https://login.yahoo.com/config/login?"
    followRedirects: true
    followAllRedirects: true
    form: 
      ".done": "http://baseball.fantasysports.yahoo.com/b1/90736/standings?.scrumb=0"
      passwd: creds.pass
      name: creds.user

  request.post opts, onStandings

module.exports = getStats