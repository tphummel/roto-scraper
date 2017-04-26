#!/usr/bin/env node

var fs = require('fs')
var path = require('path')
var lib = require('.')

var inFile = process.argv[2]

if (['help', '--help'].includes(inFile)) {
  console.log(`
USAGE:
  node ./bin.js ./my-input-file.html > ./outfile.json
  `)
  process.exit(0)
}

var htmlFile = path.join(__dirname, inFile)
fs.readFile(htmlFile, 'utf8', function (err, text) {
  if (err) return console.log(err) && process.exit(1)
  return lib(text, function (err, data) {
    if (err) return console.log(err) && process.exit(1)
    return console.log(JSON.stringify(data))
  })
})
