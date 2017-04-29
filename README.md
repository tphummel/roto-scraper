# onroto standings scraper #

[![Greenkeeper badge](https://badges.greenkeeper.io/tphummel/onroto-standings-scraper.svg)](https://greenkeeper.io/)[![Build Status](https://travis-ci.org/tphummel/onroto-standings-scraper.png)](https://travis-ci.org/tphummel/onroto-standings-scraper) [![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/feross/standard)
[![Docker Repository on Quay](https://quay.io/repository/tomh/onroto-standings-scraper/status "Docker Repository on Quay")](https://quay.io/repository/tomh/onroto-standings-scraper)

convert onroto.com standings html to json

## usage

```
npm install -g onroto-standings-scraper

curl http://baseball1.onroto.com/baseball/webtest/display_stand.pl?leagueid&session_id=XXXYYY > standings.html

onroto-standings-scraper ./standings.html > standings.json

cat standings.json | jq ".standingsDate"
> "2017-04-28"
```

## docker usage

```
curl http://baseball1.onroto.com/baseball/webtest/display_stand.pl?leagueid&session_id=XXXYYY > /Users/tom/baseball/standings.html

docker run --rm tomh/onroto-standings -v /Users/tom/baseball:/var/data/ /var/data/standings.html > standings.json

cat standings.json | jq ".standingsDate"
> "2017-04-28"
```

**note**: usage examples reference the [jq](https://stedolan.github.io/jq/) library. this is not strictly required.

## development

```
git clone https://github.com/tphummel/onroto-standings-scraper.git oss
cd oss
npm install

./bin.js --help
```
