JSONStream = require "JSONStream"
through    = require "through"
Stream     = require 'stream'

createStream = (cursor) ->
  s = new Stream
  s.readable = true

  cursor.forEach (item) ->
    s.emit 'data', item 
  , (err) ->
    s.emit 'end'

  return s

defaultTransform = (data) -> 
  data._id = data._id.toString()
  @queue data

module.exports = (opts) ->
  transform = opts.transform or defaultTransform
  {query, response} = opts

  response.set "Content-Type", "application/json"
  
  mongoReadable = createStream query
  
  stringify = JSONStream.stringify()
  transform = through transform
  
  mongoReadable.pipe(transform).pipe(stringify).pipe(response)