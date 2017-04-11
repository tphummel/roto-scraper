# onroto standings scraper #

[![Build Status](https://travis-ci.org/tphummel/onroto-standings-scraper.png)](https://travis-ci.org/tphummel/onroto-standings-scraper) [![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/feross/standard)
[![Docker Repository on Quay](https://quay.io/repository/tomh/onroto-standings-scraper/status "Docker Repository on Quay")](https://quay.io/repository/tomh/onroto-standings-scraper)

convert onroto.com standings html to json

## setup
log in to your league and then save the url to the standings page include the querystring

```
export ONROTO_HOST=baseball1.onroto.com
export ONROTO_PATH=/baseball/webtest/display_stand.pl?leagueid&session_id=XXXYYY
```

## usage

```
git clone https://github.com/tphummel/onroto-standings-scraper.git oss
cd oss
npm install
node ./bin.js
```

## prebuilt docker image usage

```
docker run -it --rm -e ONROTO_HOST -e ONROTO_PATH quay.io/tomh/onroto-standings-scraper
```

## vanilla docker usage

```
git clone https://github.com/tphummel/onroto-standings-scraper.git oss
cd oss
npm install
docker run -it --rm --name onroto-standings-scraper -v "$PWD":/usr/src/app -e ONROTO_HOST -e ONROTO_PATH -w /usr/src/app node:alpine node ./bin.js
```

## docker build

```
docker build .
docker push quay.io/tomh/onroto-standings-scraper
```
