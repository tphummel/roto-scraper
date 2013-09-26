mongoStream = require "../mongo_stream"
{standings} = require "../db"

byDate = (req, res) ->
  date = req.params.date
  query = standings.find {thru_date: date}
  
  mongoStream 
    query: query
    response: res
      
module.exports = 
  byDate: byDate