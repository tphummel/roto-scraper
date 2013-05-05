process.env.NODE_ENV = 'test'
process.env.PORT = process.env.PORT or '4000'

require './specs/'