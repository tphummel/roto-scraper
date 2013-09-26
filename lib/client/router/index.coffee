main = require '../main/index.coffee'

module.exports = 
  '/': -> location.hash = '/reports'
  '/reports': main