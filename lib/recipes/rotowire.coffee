request = require "request"

onStandings = (e, r, body) ->
  console.log "e: ", e if e?
  console.log "standings: ", body

getStats = ->

  opts = 
    uri: "http://www.rotowire.com/users/signon.htm"
    followRedirects: true
    followAllRedirects: true
    form: 
      p1: "3clr465"
      UserName: "tphummel"
      submit: "Login"
      link: "/mlbcommish13/standingstext.htm?leagueid=420"
      x: 31
      y: 16

  request.post opts, onStandings

module.exports = getStats