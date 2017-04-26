#!/usr/bin/env node

var http = require('http')
var oss = require('../')

function onDocument (err, doc) {
  if (err) console.error(err)

  oss(doc, function (err, result) {
    if (err) console.error(err)

    console.log(JSON.stringify(result))
  })

}

function onResponse (response) {
  var str = ''

  response.on('data', function (chunk) {
    str += chunk
  })

  response.on('end', function () {
    onDocument(null, str)
  })
}

var options = {
  // 'baseball1.onroto.com'
  host: process.env.ONROTO_HOST,
  // '/baseball/webtest/display_stand.pl?leagueid&session_id=SESSIONTOKEN'
  path: process.env.ONROTO_PATH
}

http.request(options, onResponse).end()
