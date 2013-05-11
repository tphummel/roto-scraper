fs = require "fs"
async = require "async"
{getStats, onStandings} = require "../lib/recipes/rotowire"
{standings} = require "../lib/db"


dataDir = __dirname+"/../data/rotowire/"
files = fs.readdirSync dataDir
console.log "files: ", files

async.eachSeries files, (file, done) ->
  console.log "starting file: #{file}"

  fs.readFile dataDir+file, "utf8", (e, b) ->
    docs = onStandings e, null, b
    async.each docs, (doc, cb) ->
      q = 
        league: doc.league
        thru_date: doc.thru_date
        team: doc.team
        
      standings.update q, doc, {upsert:true}, cb
    , (e) ->
      console.log "done with file: #{file}"
      done e
, (e) ->
  console.log "all done"
  process.exit 0
