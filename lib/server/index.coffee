express = require "express"
standings = require "./standings"

app = express()

logRoute = (req, res, next) ->
  meta = 
    timestamp: new Date()
    path: req.path
    query: req.query
    msg: "route"
    
  console.log (JSON.stringify meta)
  
  next()

app.use express.bodyParser()
app.use logRoute
app.use app.router

{version} = require '../../package.json'
app.get '/health', (req, res) -> res.json {status: 'ok', time: new Date, version: version}
app.get '/standings/:date', standings.index

scrapeLoop = require "./scrape_loop"

port = process.env.PORT || 3000
app.listen port 

console.log "roto-scraper running on port #{port}"