fs              = require 'fs'
browserify      = require 'browserify'
simpleJadeify   = require 'simple-jadeify'
coffeeify       = require 'coffeeify'
sassify         = require 'sassify'

vendor = [
  './lib/client/vendor/jquery.min.js'
  './lib/client/vendor/bootstrap.js'
]

opts =
  noParse: vendor
  
if process.env.NODE_ENV is 'development'
  opts.debug = true

bundle = browserify opts

bundle.transform simpleJadeify
bundle.transform coffeeify
bundle.transform sassify

for js in vendor
  bundle.add js

bundle.add './lib/client/entry.coffee'

out = fs.createWriteStream './public/main.js'
bs = bundle.bundle()
bs.pipe out

bs.on 'end', -> 
  bundle.emit 'end'
  console.log "browserified..."

module.exports = bundle