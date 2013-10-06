assert  = require("chai").assert
fs      = require "fs"

rotowire = require __dirname+"/../../lib/server/recipes/rotowire"

describe "Rotowire", ->
  it "create final docs from raw html", ->
    rawHtml = fs.readFileSync __dirname+"/../fixtures/raw_standings.html", "utf8"
    expected = JSON.parse (require __dirname+"/../fixtures/expected_result")
    
    docs = rotowire.onStandings null, null, rawHtml
    for doc, i in docs
      eDoc = expected[i]
      for key, val of doc
        unless key is "created_at"
          assert.deepEqual val, eDoc[key]