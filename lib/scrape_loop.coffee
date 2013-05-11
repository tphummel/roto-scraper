async = require "async"
{getStats, onStandings} = require "../recipes/rotowire"
{standings} = require "../db"

saveDoc = (doc, cb) ->
  q = 
    league: doc.league
    thru_date: doc.thru_date
    team: doc.team
    
  standings.update q, doc, {upsert:true}, cb

saveDocs = (docs, cb) -> async.each docs, saveDoc, cb

scrapeNow = ->
  getStats (e,r,b) ->
    console.log "e: ", e if e
    docs = onStandings e, r, b
    byDate = {}
    for doc in docs
      byDate[doc.thru_date] ?= 0
      byDate[doc.thru_date] += 1

    saveDocs docs, (e) ->
      console.log "e: ", e if e
      console.log "done scraping: #{JSON.stringify byDate}"

loopInterval = 60 * 1000 * 60 * 6 # every 6 hours
setInterval scrapeNow, loopInterval