path = require 'path'
try
  parameters = require './parameters'
  params = parameters.parse()
  params.port ?= 3000
  params.engine ?= 'jade'
catch e
  console.log e.message
  console.log ''
  params = help: true
return console.log parameters.help() if params.help

fs = require 'fs'
http = require 'http'
nib = require 'nib'
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
methodOverride = require 'method-override'
session = require 'express-session'
favicon = require 'serve-favicon'
serve_index = require 'serve-index'
serve_static = require 'serve-static'
jade_static = require 'connect-jade-static'
each = require 'each'

commands = require './commands'
webpack = require './webpack_server'

app = express()
server = http.Server(app)

app.set 'views', path.resolve __dirname, '../public'
app.set 'view engine', params.engine
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser 'my secret'
app.use methodOverride '_method'
app.use session secret: 'my secret', resave: true, saveUninitialized: true
app.use favicon __dirname + '/../public/favicomatic/favicon.ico'

modules = require './modules'
app.use modules

app.use jade_static
  baseDir: path.join __dirname, '/../src'
  baseUrl: '/'
  maxAge: 86400
  serveIndex: true
  jade: pretty: true

# Launch webpack dev middleware
webpack(app)

remarkable = require 'remarkable'
md = new remarkable 'full'

app.get '/', (req, res) ->
  res.render 'index.jade'

app.get '/modules', (req, res) ->
  res.render 'modules.jade', modules: req.modules.full

app.get '/modules.json', (req, res) ->
  res.json req.modules.by_name

app.get /^\/module\/.*/, (req, res, next) ->
  name = req.url.split('/').slice(2).join('/')
  module = req.modules.by_name[name]
  res.render 'module.jade', title : module.title, srcmd: module.html

app.get '/command/:command.json', (req, res, next) ->
  commands req.params.command, (err, data) ->
    return next err if err
    res.json data

app.get '/documentation',  (req, res)  ->
  res.render 'documentation/index.jade', title: 'Getting Started'

app.get '/documentation/**', (req, res, next) ->
  return next() if /\./.test path.basename req.url
  filename = req.url
  filename = filename.substr 0, filename.length - 1 if /\/$/.test filename
  # title = "#{filename}"
  # title = "#{title.charAt(0).toUpperCase()}#{title.slice 1}"
  filename = "#{path.join __dirname, '/../public/',filename}.md"
  fs.readFile filename, 'utf8', (err, content) ->
    return next err if err
    try
      html = md.render content
      res.render 'documentation/documentation.jade',  title: "Ryba's Documentation", srcmd: html
    catch err
      fn err

app.use serve_static path.resolve __dirname, '../public'
app.use serve_index path.resolve __dirname, '../public'

app.use (err, req, res, next) ->
  console.log 'error', err.code, err
  code = if typeof err.code is 'number' then err.code else 500
  code = 404 if err.code is 'ENOENT'
  res.status(code).render 'error.jade', error: err
  res.status(code).json err

server.listen params.port, console.log 'running on port ' + params.port
module.exports = server
