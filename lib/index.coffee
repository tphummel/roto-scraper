process.env.NODE_ENV ?= 'dev'

require './server'

if process.env.NODE_ENV is 'dev'
  require 'deadreload'