
path = require 'path'
try
  parameters = require('./parameters')
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
morgan = require 'morgan'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
methodOverride = require 'method-override'
session = require 'express-session'
errorhandler = require 'errorhandler'
serve_favicon = require 'serve-favicon'
serve_index = require 'serve-index'
serve_static = require 'serve-static'
jade_static = require 'connect-jade-static'

commands = require './commands'

app = express()
server = http.Server(app)
app.set 'views', path.resolve __dirname, '../public'
app.set 'view engine', params.engine
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser 'my secret'
app.use methodOverride '_method'
app.use session secret: 'my secret', resave: true, saveUninitialized: true



modules = require './modules'
app.use modules

app.use jade_static
  baseDir: path.join __dirname, '/../src'
  baseUrl: '/'
  maxAge: 86400
  serveIndex: true
  jade: pretty: true

app.use serve_static path.resolve __dirname, '../src'

remarkable = require 'remarkable'
md = new remarkable 'full'

app.get '/modules.json', (req, res) ->
  by_name = {}
  for name, mod of req.modules.by_name
    by_name[mod.name] = name: mod.name, title: mod.title, index: mod.index or false
  res.json by_name: by_name, commands: req.modules.commands

app.get /module\/.*/, (req, res, next) ->
  name = req.url.split('/').slice(2).join('/')
  # name = "#{path.dirname name}/#{path.basename name, '.html'}"
  # name = "#{path.dirname name}/#{name}"
  filename = "#{__dirname}/../node_modules/#{name}.coffee.md"
  fs.readFile filename, 'utf8', (err, content) ->
    return next err if err
    srcmd = md.render content
    res.render 'module.jade', title: 'Express', srcmd: srcmd

app.get '/command/:command.json', (req, res, next) ->
  commands req.params.command, (err, data) ->
    return next err if err
    res.json data

app.use serve_static path.resolve __dirname, '../public'

app.get '/documentation/:page', (req, res, next) ->
  filename = req.params.page.split('/').slice(0)
  title = "#{filename}"
  title = "#{title.charAt(0).toUpperCase()}#{title.slice 1}"
  filename = "#{filename}.md"
  filename = "#{path.join __dirname, '/../public/documentation/',filename}"
  fs.readFile filename, 'utf8', (err, content) ->
    return next err if err
    try
      html = md.render content
      res.render 'documentation/documentation.jade',  title: "#{title} - Ryba's Documentation", srcmd: html
    catch err
      fn err
    return
  return 

app.get '/', (req, res) ->
  res.render 'index.jade'

app.get '/modules', (req, res) ->
  modules = for name in Object.keys(req.modules.by_name).sort()
    mod = req.modules.by_name[name]
    name: mod.name, title: mod.title, description: mod.description, index: mod.index or false
  res.render 'modules.jade', modules: modules
  
app.get '/documentation',  (req, res)  ->
  res.render 'documentation/index.jade', title: 'Getting Started'


# app.get /.*/, (req, res, next) ->
#   dirname = path.join params.public, path.dirname req.url
#   basename = path.basename req.url
#   # urlname = if path.extname(req.url) is '.html' then "#{path.basename(req.url, '.html')}.#{params.engine}" else req.url
#   fs.readdir dirname, (err, files) ->
#     return next() if err
#     jadename = basename.split('.').slice(0, -1).join('.') + '.jade'
#     return do_jade path.join(dirname, jadename) if jadename in files
#     mdname = basename.split('.').slice(0, -1).join('.') + '.coffee.md'
#     return do_md path.join(dirname, mdname) if mdname in files
#     fs.stat path.join(dirname, basename), (err, stat) ->
#       return next() if err
#       if stat.isFile()
#         res.render url, title: 'Express'
#       else if stat.isDirectory()
#         fs.readdir path.join(dirname, basename), (err, files) ->
#           jadename = 'index.jade'
#           return do_jade path.join(dirname, 'index.jade') if jadename in files
#           return do_md dirname + '/index.coffee.md' if jadename in files
#           next()
#   do_jade = (filename) ->
#     res.render filename, title: 'Express'
#   do_md = (filename) ->
#     fs.readFile filename, 'utf8', (err, content) ->
#       return next err if err
#       srcmd = md.render content
#       res.render 'module.jade', title: 'Express', srcmd: srcmd

app.use serve_index path.resolve __dirname, '../public'

# if process.env.NODE_ENV is 'development'
#   app.use errorhandler()

app.use (err, req, res, next) ->
  code = if typeof err.code is 'number' then err.code else 500
  code = 404 if err.code is 'ENOENT'
  console.log err
  res.status(code).render 'error.jade', error: err

server.listen params.port
module.exports = server
