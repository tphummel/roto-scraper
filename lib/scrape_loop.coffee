async = require "async"
moment = require "moment"
fs = require "fs"
{getStats, onStandings} = require "./recipes/rotowire"
{standings} = require "./db"

saveDoc = (doc, cb) ->
  q = 
    league: doc.league
    thru_date: doc.thru_date
    team: doc.team
    
  standings.update q, doc, {upsert:true}, cb

saveDocs = (docs, cb) -> async.each docs, saveDoc, cb

getScrapeDate = (docs) ->
  byDate = {}
  for doc in docs
    byDate[doc.thru_date] ?= 0
    byDate[doc.thru_date] += 1
  date = (Object.keys byDate)[0]
  return date

scrapeNow = ->
  getStats (e,r,b) ->
    docs = onStandings e, r, b

    scrapeDate = getScrapeDate docs
    fs.writeFileSync __dirname+"/../data/rotowire/t#{scrapeDate}.html", b
    console.log "e: ", e if e

    saveDocs docs, (e) ->
      console.log "e: ", e if e
      console.log "done scraping & saving: thru #{scrapeDate} at #{new Date}"

loopInterval = 60 * 1000 * 60 * 6 # every 6 hours
setInterval scrapeNow, loopInterval
scrapeNow()