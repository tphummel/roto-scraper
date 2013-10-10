$("button.thru-date").click ->
  date = $("#report-date").val()
  window.location = "/thru-date/#{date}"