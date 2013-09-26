style = require './style.scss'
template = require './template.jade'

module.exports = ->
  target = @target
  target.empty()
  target.append template

  $("ul.nav li a").click ->

    $("ul.nav li").removeClass "active"
    
    anchor = $(this)[0]
    li = $(anchor)[0].parentElement
    $(li).addClass "active"