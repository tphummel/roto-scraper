mc = require "mongo-collection"

module.exports = 
  standings: mc "localhost", "roto-scraper", "standings"