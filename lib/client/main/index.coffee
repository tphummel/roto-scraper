style = require './style.scss'
template = require './template.jade'

module.exports = ->
  console.log "target: ", target
  console.log "template: ", template
  target = @target
  target.empty()
  target.append template