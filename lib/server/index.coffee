express       = require "express"
healthCheck   = require "connect-health-check"

bundle  = require "./bundle"
api     = require "./api"
reports = require "./reports"

app = express()
app.configure ->
  app.use healthCheck
  app.use express.json()
  app.use express.static './public', {maxAge: 86400000}

  express.logger.token 'ts', -> (new Date).toISOString()
  app.use express.logger JSON.stringify 
    ts: ':ts'
    method: ':method'
    url: ':url'
    status: ':status'
    ip: ':remote-addr'
    response_time: ':response-time'

app.set 'views', './lib/server/views'
app.get '/', (req, res) -> res.render 'index.jade'

app.get '/api/standings/:date', api.standings.byDate
reports app

scrapeLoop = require "./scrape_loop"

port = process.env.PORT or 3000
app.listen port 

console.log "roto-scraper running on port #{port}"