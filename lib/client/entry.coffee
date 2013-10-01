$(document).ready ->

  # reverse sorting dingbats
  $.bootstrapSortable true, 'reversed'
  
  $("button.thru-date").click ->
    date = $("#report-date").val()
    window.location = "/thru-date/#{date}"

  console.log "entry loaded"