db = require "../db"
module.exports = 

module.exports = (req, res) ->
  date = req.params.date
  
  query = db.standings
    .find({thru_date: date})
    .sort({rank: 1})

  query.toArray (err, result) ->

    data = 
      standings: result
      date: date
      path: req.route.path

    res.render "reports/thru-date.jade", data