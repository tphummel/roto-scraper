Mongolian = require "mongolian"

# Create a server instance with default host and port
server = new Mongolian

# Get database
db = server.db "roto-scraper"

# Get some collections
standings = db.collection "standings"

# standings.ensureIndex {}

module.exports = 
  standings: standings