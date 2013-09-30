thruDate = require "./thru-date"

# final day of 2013 season
defaultDate = "2013-09-29"


module.exports = (app) ->
  app.get "/thru-date", (req, res) ->
    res.redirect "/thru-date/#{defaultDate}"

  app.get "/thru-date/:date", thruDate
