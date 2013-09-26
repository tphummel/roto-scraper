Backbone = require 'backbone'
Backbone.$ = $

router       = require 'directify'
routingTable = require './router/index.coffee'

$(document).ready ->
  router routingTable, $('#container')
  if window.location.hash is ''
    window.location.hash = '/'