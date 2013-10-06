db = require "../db"

roundRatio = (val) -> return val.toFixed 4

transforms = 
  WHIP: roundRatio
  ERA: roundRatio
  Avg: roundRatio

module.exports = (req, res) ->
  dateStart = req.params.dateStart
  dateEnd = req.params.dateEnd
  
  query = db.standings
    .find({thru_date: {$in: [dateStart, dateEnd]}})

  query.toArray (err, result) ->
    diffed = doDiff [dateStart, dateEnd], result

    standings = []
    for k, v of diffed
      v.team = k
      standings.push v 

    data = 
      standings: standings
      categories: (Object.keys result[0].stats).slice 0, -1
      dateStart: dateStart
      dateEnd: dateEnd
      path: req.route.path

    res.render "reports/diff.jade", data

doDiff = (rptDates, data) ->
  mapped = byTeamDate data

  final = diffMapped rptDates, mapped
  
diffMapped = (rptDates, mapped) ->
  final = {}

  for team, byDay of mapped

    final[team] = {}

    start = byDay[rptDates[0]]
    end = byDay[rptDates[1]]

    for category, detail of start

      diff = 
        points: end[category].points - start[category].points
        stat: end[category].stat - start[category].stat

      if transforms[category]?
        diff.stat = transforms[category] diff.stat

      final[team][category] = diff

  return final
      
byTeamDate = (data) ->
  mapped = {}
  for rec in data
    tm = mapped[rec.team] ?= {}

    dt = tm[rec.thru_date] = rec.stats

    dt.total = 
      points: rec.points
      stat: rec.rank

  mapped