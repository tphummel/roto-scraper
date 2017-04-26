# onroto standings scraper #

[![Greenkeeper badge](https://badges.greenkeeper.io/tphummel/onroto-standings-scraper.svg)](https://greenkeeper.io/)[![Build Status](https://travis-ci.org/tphummel/onroto-standings-scraper.png)](https://travis-ci.org/tphummel/onroto-standings-scraper) [![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/feross/standard)
[![Docker Repository on Quay](https://quay.io/repository/tomh/onroto-standings-scraper/status "Docker Repository on Quay")](https://quay.io/repository/tomh/onroto-standings-scraper)

convert onroto.com standings html to json

## usage

```
git clone https://github.com/tphummel/onroto-standings-scraper.git oss
cd oss
npm install

curl http://baseball1.onroto.com/baseball/webtest/display_stand.pl?leagueid&session_id=XXXYYY > standings.html
./bin.js ./standings.html > standings.json
```
