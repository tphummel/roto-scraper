#!/usr/bin/env bash

npm install onroto-standings-scraper
npm install -g jsontool

export ONROTO_HOST="baseball1.onroto.com"
export ONROTO_PATH="/baseball/webtest/display_stand.pl?LEAGUE&session_id=SESSIONID"

echo "ONROTO_HOST: $ONROTO_HOST"
echo "ONROTO_PATH: $ONROTO_PATH"

echo "making sure ../data/ exists"
mkdir -p ../data/

local json_result=$(./node_modules/.bin/onroto-standings-scraper)

echo "result: $json_result"

local standings_date=$(echo $json_result | json "standingsDate")

echo "standingsDate: $standings_date"

local outfile="../data/$standings_date.json"

echo "writing output to: $outfile"
echo $json_result > "$outfile"

# print bytecount of output file
wc -c $outfile

# sync files to s3 bucket
aws s3 sync ../data/ s3://mybucket/myleague/2015season/
