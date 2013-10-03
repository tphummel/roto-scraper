# roto scraper #

scrapes rotisserie stats and saves to mongodb

## deploy
bundle exec knife solo bootstrap tom@198.199.109.183 --bootstrap-version=10.26.0


## setup

create config/ dir in project root

create file config/creds.coffee. for my rotowire recipe, my config looks like this:
    
    module.exports = 
      rotowire:
        user: "username"
        pass: "password"
        leagueId: "123"
      yahoo: 
        user: "username"
        pass: "password"
        leagueId: "456"
      espn: 
        user: "username"
        pass: "password"
        leagueId: "789"

then i set up a cron task to run the script sometime after the standings have been compiled.

temporary, save raw html to file:

    node index.js > data/rotowire/2013-04-09.html

## api

- /standings/:date

- /standings/:team

- /standings/:team?dateStart=&dateEnd=

- /standings/?dateStart=&dateEnd=

- /standings


## reports

- standings for single date
- standings change over date span
- current standings with change t-1, t-7, t-14, t-21, t-28
- largest single day change by category (category drop down)

## TODO
- deploy node 10 to donaldson
- diff & thru-date
  - optional format fn (rounding)
  - toggle stat / pts
- deploy app
- email link to league
- "last scraped" timestamp in header
