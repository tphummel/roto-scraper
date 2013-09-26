express = require "express"
api = require "./api"
{version} = require '../../package.json'

app = express()

app.use express.json()
app.use app.router
app.use express.static './public', {maxAge: 86400000}
express.logger.token 'ts', -> (new Date).toISOString()
app.use express.logger JSON.stringify 
  ts: ':ts'
  method: ':method'
  url: ':url'
  status: ':status'
  ip: ':remote-addr'
  response_time: ':response-time'

app.get '/api/health', (req, res) -> res.json {status: 'ok', time: new Date, version: version}
app.get '/api/standings/:date', api.standings.byDate


scrapeLoop = require "./scrape_loop"

port = process.env.PORT or 3000
app.listen port 

console.log "roto-scraper running on port #{port}"