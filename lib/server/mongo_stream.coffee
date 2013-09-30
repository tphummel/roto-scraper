JSONStream = require "JSONStream"
through    = require "through"
Stream     = require 'stream'

createStream = (cursor) ->
  s = new Stream
  s.readable = true

  cursor.each (err, item) ->
    if item
      s.emit 'data', item 
    else
      s.emit 'end'

  return s

module.exports = (opts) ->
  {query, response} = opts

  response.set "Content-Type", "application/json"
  
  mongoReadable = createStream query
  
  stringify = JSONStream.stringify()
  
  mongoReadable.pipe(stringify).pipe(response)




  Stream     = require 'stream'
  JSONStream = require "JSONStream"

  createStream = (cursor) ->
    s = new Stream
    s.readable = true

    cursor.each (err, item) ->
      if item
        s.emit 'data', item 
      else
        s.emit 'end'

    return s


  module.exports = (cursor, res) ->

    res.set "Content-Type", "application/json"
    
    stream = createStream cursor
    stringify = JSONStream.stringify()
    
    stream.pipe(stringify).pipe(res)