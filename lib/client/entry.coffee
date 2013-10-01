main = require "./main/index.coffee"

$(document).ready ->
  
  $("button.thru-date").click ->
    date = $("#report-date").val()
    window.location = "/thru-date/#{date}"

  console.log "entry loaded"