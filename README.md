# roto scraper #

scrapes rotisserie stats and saves to mongodb

## setup

- create config/ dir in project root
- create file config/creds.coffee. for my rotowire recipe, my config looks like this:
    
    module.exports = 
      rotowire:
        user: "username"
        pass: "password"

- then i set up a cron task to run the script sometime after the standings have been compiled.


node index.js > data/rotowire/2013-04-09.html