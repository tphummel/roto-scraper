async = require "async"
moment = require "moment"
fs = require "fs"
{getStats, onStandings} = require "./recipes/rotowire"
{standings} = require "./db"

activeRecipes = ["rotowire"]

getActiveRecipes = ->
  recipes = {}
  (fs.readdirSync __dirname+"/recipes").forEach (file) ->
    shortFile = file.split(".")[0]
    if shortFile in activeRecipes
      recipe = require __dirname+"/recipes/"+file
      recipes[shortFile] = recipe
  return recipes

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

    saveDocs docs, (e) ->
      meta = 
        timestamp: new Date
        msg: "scrape"
        status: e or "ok"
      console.log (JSON.stringify meta)

loopInterval = 60 * 1000 * 60 * 6 # every 6 hours
setInterval scrapeNow, loopInterval
scrapeNow()