var fs = require('fs')
var path = require('path')
var test = require('tape')
var lib = require('../')

test('scrape test file', function(t){
  var htmlFile = path.join(__dirname, 'fixtures/test.html')
  fs.readFile(htmlFile, function(err, text){
    t.equal(err, null)

    lib(text, function(err, result){
      t.equal(err, null)
      t.equal(result.standingsDate, '2015-04-04')
      t.equal(result.seasonStandings.length, 11)
      t.equal(result.weekStandings.length, 11)
      t.equal(result.categoryStandings.length, 11)
      t.end()
    })
  })



})
