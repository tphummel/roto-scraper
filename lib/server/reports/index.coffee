thruDate  = require "./thru-date"
diff      = require "./diff"

defaultDate = "2013-10-01"
defaultDateStart = "2013-09-01"

module.exports = (app) ->
  app.get "/thru-date", (req, res) ->
    res.redirect "/thru-date/#{defaultDate}"

  app.get "/thru-date/:date", thruDate

  app.get "/diff", (req, res) -> 
    ds = defaultDateStart
    de = defaultDate
    res.redirect "/diff/#{ds}/#{de}"

  app.get "/diff/:dateStart", (req, res) -> 
    ds = req.params.dateStart
    de = defaultDate
    res.redirect "/diff/#{ds}/#{de}"

  app.get "/diff/:dateStart/:dateEnd", diff
