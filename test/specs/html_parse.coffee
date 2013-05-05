assert  = require("chai").assert
fs      = require "fs"
$       = require "jquery"
_       = require "underscore"
rawHtml = fs.readFileSync __dirname+"/../fixtures/day_standings.html", "utf8"

getDate = (lines) ->
  date = null

  dateRegexp = /[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/
  arrMatch = lines[0].match dateRegexp

  date = arrMatch[0] if arrMatch[0]

  return date

doOverallTable = (csvTable, byTeam) ->
  headers = csvTable[0]
  arrHeaders = (headers.split ",").map (field) -> field.replace /\s+/, ""
  arrHeaders = arrHeaders.slice 0, -1

  csvTeams = csvTable.slice 1

  for line in csvTeams
    fields = line.split ","
    teamName = fields[0]
    byTeam[teamName] = {}

    fields = fields.slice 1
    statHeaders = arrHeaders.slice 1

    for header, i in statHeaders
      byTeam[teamName][header] = {}

      trimmedStat = fields[i].replace /\s+/, ""
      floatStat = parseFloat trimmedStat
      byTeam[teamName][header].points = floatStat    

groupLines = (lines) ->
  categoryGroups = []
  for line, i in lines
    groupIx = Math.floor (i / 14)
    categoryGroups[groupIx] ?= []
    categoryGroups[groupIx].push line

  categoryGroups = categoryGroups.slice 0, -1

describe "HTML Parse", ->
  it "get csv from html", ->
    categories = [
      {long: "Batting Average", short: "Avg", type: "float"}
      {long: "Home Runs (Batter)", short: "HR", type: "int"}
      {long: "RBI", short: "RBI", type: "int"}
      {long: "Runs (Batter)", short: "R", type: "int"}
      {long: "Stolen Bases", short: "SB", type: "int"}
      {long: "ERA", short: "ERA", type: "float"}
      {long: "Saves", short: "S", type: "int"}
      {long: "Strikeouts", short: "K", type: "int"}
      {long: "WHIP", short: "WHIP", type: "float"}
      {long: "Wins", short: "W", type: "int"}
    ]

    longToShort = {}
    for cat in categories
      longToShort[cat.long] = cat.short

    longCats = categories.map (cat) -> cat.long
    shortCats = categories.map (cat) -> cat.short
    byTeam = {}

    content = $(rawHtml).find(".content").text()
    lines = (content.split "\n").filter (line) -> line.length > 0
    date = getDate lines

    csvOverall = lines.slice 1,14

    doOverallTable csvOverall, byTeam

    categoryLines = lines.slice 14
    categoryGroups = groupLines categoryLines

    for group in categoryGroups
      statName = group[0]
      statDetail = _.find categories, (cat) -> cat.long is statName
      headers = group[1].split ","

      teamLines = group.slice 2
      for line in teamLines
        fields = line.split ","
        team = fields[0]
        stat = fields[1]

        if statDetail.type is "float"
          stat = parseFloat stat
        else if statDetail.type is "int"
          stat = parseInt stat

        byTeam[team][statDetail.short].stat = stat


    console.log "byTeam: ", byTeam


    # console.log "lines: ", lines

    

