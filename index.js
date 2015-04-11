var cheerio = require('cheerio')
var moment = require('moment')

module.exports = scrapeStandings

function scrapeStandings (text, cb) {
  var dom = cheerio.load(text)

  return cb(null, {
    standingsDate: getStandingsDate(dom),
    seasonStandings: getSeasonStandings(dom),
    weekStandings: getWeekStandings(dom),
    categoryStandings: getCategoryStandings(dom)
  })
}

function getStandingsDate (dom) {
  var headings = dom('font b').filter(function (i) {
    var inner = dom(this).text()
    return /STANDINGS/.test(inner)
  })

  var seasonHeading = headings[0]

  var rawDate = dom(seasonHeading).text().match(/\d{2}\.\d{2}\.\d{2}/)
  var prettyDate = moment(rawDate, 'MM.DD.YY').format('YYYY-MM-DD')

  return prettyDate
}

function getSeasonStandings (dom) {
  var tables = dom("table [cellpadding='2']")
  var seasonTable = tables[0]
  var rows = dom(seasonTable).children('tr')

  var keys = []
  dom(rows)
    .first()
    .children('th')
    .each(function (i) {
      keys.push(dom(this).text().trim())
    })

  var standings = []
  dom(rows)
    .slice(1)
    .each(function (i) {
      var team = {
        order: i
      }

      dom(this)
        .children('td')
        .each(function (j) {
          team[keys[j]] = dom(this).text().trim()
        })

      standings.push(team)
    })

  return standings
}

function getWeekStandings (dom) {
  var tables = dom("table [cellpadding='2']")
  var weekTable = tables[1]

  var rows = dom(weekTable).children('tr')

  var keys = []
  dom(rows)
    .first()
    .children('th')
    .each(function (i) {
      keys.push(dom(this).text().trim())
    })

  var standings = []
  dom(rows)
    .slice(1)
    .each(function (i) {
      var team = {
        order: i
      }

      dom(this)
        .children('td')
        .each(function (j) {
          team[keys[j]] = dom(this).text().trim()
        })

      standings.push(team)
    })

  return standings
}

function getCategoryStandings (dom) {
  var tables = dom("table [cellpadding='2']")
  var catParentTable = tables[2]

  var teams = {}

  dom(catParentTable)
    .children('tr')
    .children('td')
    .children('table')
    .each(function (i) {
      var category = dom(this)
        .children('tr')
        .slice(0, 1)
        .text()
        .trim()

      var keys = []
      dom(this)
        .children('tr')
        .slice(1, 2)
        .children('th')
        .each(function (j) {
          keys.push(dom(this).text().trim())
        })

      dom(this)
        .children('tr')
        .slice(2)
        .each(function (k) {
          var teamName = dom(this)
            .children('td')
            .slice(0, 1).text().trim()

          if (!teams[teamName]) {
            teams[teamName] = {
              team: teamName
            }
          }

          if (!teams[teamName][category]) {
            teams[teamName][category] = {}
          }

          dom(this)
            .children('td')
            .slice(1)
            .each(function (l) {
              teams[teamName][category][keys[l + 1]] = dom(this).text().trim()
            })
        })
    })

  var teamsArr = Object.keys(teams)
    .map(function (team) {
      return teams[team]
    })
  return teamsArr
}
