mongo_stream = require "../mongo_stream"

{standings} = require "../db"

index = (req, res) ->
  date = req.params.date
  query = standings.find {thru_date: date}
  
  mongo_stream 
    query: query
    response: res
      
module.exports = 
  index: index