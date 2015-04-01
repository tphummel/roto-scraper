var http = require('http')
var cheerio = require('cheerio')
var moment = require('moment')

function getUrl(url, cb) {
  var req = http.get(url, function(res) {
    var data = ''

    res.on('data', function (chunk) {
      data += chunk
    })
    res.on('end', function() {
      cb(null, data)
    })
  })

  req.on('error', cb)
}

function getStandingsDate(dom){
  var headings = dom('font b').filter(function(i) {
    var inner = dom(this).text()
    return /STANDINGS/.test(inner)
  })

  var seasonHeading = headings[0]

  var rawDate = dom(seasonHeading).text().match(/\d{2}\.\d{2}\.\d{2}/)
  var prettyDate = moment(rawDate, 'MM.DD.YY').format('YYYY-MM-DD')

  return prettyDate
}

function getSeasonStandings(dom){
  var tables = dom("table [cellpadding='2']")
  var seasonTable = tables[0]
  var rows = dom(seasonTable).children('tr')

  var keys = []
  dom(rows)
    .first()
    .children('th')
    .each(function(i){
      keys.push(dom(this).text().trim())
    })

  var standings = []
  dom(rows)
    .slice(1)
    .each(function(i){

      var team = {
        order: i
      }

      dom(this)
        .children('td')
        .each(function(j){
          team[keys[j]] = dom(this).text()
        })

      standings.push(team)
    })

  return standings
}

function getWeekStandings(dom){
  var tables = dom("table [cellpadding='2']")
  var weekTable = tables[1]

  var rows = dom(weekTable).children('tr')

  var keys = []
  dom(rows)
    .first()
    .children('th')
    .each(function(i){
      keys.push(dom(this).text().trim())
    })

  var standings = []
  dom(rows)
    .slice(1)
    .each(function(i){

      var team = {
        order: i
      }

      dom(this)
        .children('td')
        .each(function(j){
          team[keys[j]] = dom(this).text()
        })

      standings.push(team)
    })

  return standings
}

function getCategoryStandings(dom){
  var tables = dom("table [cellpadding='2']")
  var catParentTable = tables[2]
}

function scrapeStandings(text, cb){
  var dom = cheerio.load(text)

  standingsDate = getStandingsDate(dom)
  seasonStandings = getSeasonStandings(dom)
  weekStandings = getWeekStandings(dom)

  var result = {
    standingsDate: standingsDate,
    seasonStandings: seasonStandings,
    weekStandings: weekStandings
  }

  return cb(null, result)
}

function extractSeason(text, cb){

}
module.exports = {
  scrapeStandings: scrapeStandings
}


