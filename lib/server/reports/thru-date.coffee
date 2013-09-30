db = require "../db"
module.exports = 

module.exports = (req, res) ->
  date = req.params.date
  
  query = db.standings
    .find({thru_date: date})
    .sort({rank: 1})

  query.toArray (err, result) ->
    res.render "reports/thru-date.jade", {standings: result}