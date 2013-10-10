$("button.diff").click ->
  dateStart = $("#report-date-start").val()
  dateEnd = $("#report-date-end").val()
  url = "/diff/#{dateStart}/#{dateEnd}"
  window.location = url

$("input.diff").change ->
  val = $(this).val()
  if val is "stat"
    $(".stat").show()
    $(".points").hide()
  else
    $(".stat").hide()
    $(".points").show()

$statRadio = $('input:radio[name=column-group]').filter("[value=points]")
$statRadio.prop "checked", true
$statRadio.change()

