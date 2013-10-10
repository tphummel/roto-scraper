fs              = require 'fs'
browserify      = require 'browserify'
coffeeify       = require 'coffeeify'


vendor = [
  './lib/client/vendor/jquery.min.js'
  './lib/client/vendor/bootstrap-3.0.0.js'
  './lib/client/vendor/bootstrap-sortable.js'
]

opts =
  noParse: vendor
  
if process.env.NODE_ENV is 'development'
  opts.debug = true

bundle = browserify opts

for js in vendor
  bundle.add js

bundle.transform coffeeify

bundle.add './lib/client/entry.coffee'

out = fs.createWriteStream './public/main.js'
bs = bundle.bundle()
bs.pipe out

bs.on 'end', -> 
  bundle.emit 'end'
  console.log "browserified..."

module.exports = bundle