$(document).ready ->

  # reverse sorting dingbats
  $.bootstrapSortable true, 'reversed'
  
  $("button.thru-date").click ->
    date = $("#report-date").val()
    window.location = "/thru-date/#{date}"

  $("button.diff").click ->
    dateStart = $("#report-date-start").val()
    dateEnd = $("#report-date-end").val()
    url = "/diff/#{dateStart}/#{dateEnd}"
    window.location = url

  console.log "entry loaded"