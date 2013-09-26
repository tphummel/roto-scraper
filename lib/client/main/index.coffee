style = require './style.scss'
template = require './template.jade'

module.exports = ->
  target = @target
  target.empty()
  target.append template