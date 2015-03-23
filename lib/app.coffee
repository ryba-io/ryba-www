
path = require 'path'
try
  parameters = require('./parameters')
  params = parameters.parse()
  params.port ?= 3000
  params.public = path.resolve process.cwd(), params.public
  params.engine ?= 'jade'
catch e
  console.log e.message
  console.log ''
  params = help: true
return console.log parameters.help() if params.help

fs = require 'fs'
http = require 'http'
stylus = require 'stylus'
nib = require 'nib'
express = require 'express'
morgan = require 'morgan'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
methodOverride = require 'method-override'
session = require 'express-session'
errorhandler = require 'errorhandler'
coffee = require 'connect-coffee-script'
serve_favicon = require 'serve-favicon'
serve_index = require 'serve-index'
serve_static = require 'serve-static'
jade_static = require 'connect-jade-static'
# cons = require 'consolidate' # dont know to process jade file

app = express()
server = http.Server(app)
# app.engine 'html', cons.jade
# app.set 'views', "#{params.public}"
# app.set 'view engine', 'html'
app.set 'views', "#{params.public}"
app.set 'view engine', params.engine
# app.use morgan 'combined'
# app.use serve_favicon "#{params.public}/favicon.ico"
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser 'my secret'
app.use methodOverride '_method'
app.use session secret: 'my secret', resave: true, saveUninitialized: true

# reactExpress = require 'react-express'
# app.use reactExpress
#   extensions: [".js", ".json", ".jsx", ".coffee"]
#   basedir: "./public/"
#   debug: false # real expensive atm if true

modules = require './modules'
app.use modules
app.use coffee
  src: "#{__dirname}/../src"
  dest: "#{__dirname}/../public"
  bare: true
app.use stylus.middleware
  src: "#{__dirname}/../src"
  dest: "#{__dirname}/../public"
  compile: (str, path) ->
    stylus(str)
    .set('filename', path)
    .set('compress', config?.css?.compress)
    .use nib()

app.use jade_static
  baseDir: path.join __dirname, '/../src'
  baseUrl: '/'
  maxAge: 86400
  serveIndex: true
  jade: pretty: true

app.use serve_static "#{params.public}"

remarkable = require 'remarkable'
md = new remarkable 'full'

app.get '/modules.json', (req, res) ->
  by_name = {}
  for name, mod of req.modules.by_name
    by_name[mod.name] = name: mod.name, title: mod.title, index: mod.index or false
  # res.json modules
  res.json by_name: by_name, commands: req.modules.commands

app.get /module\/.*/, (req, res, next) ->
  console.log 'name', req.url
  name = req.url.split('/').slice(2).join('/')
  console.log 'name', name
  name = "#{path.dirname name}/#{path.basename name, '.html'}"
  console.log 'name', name
  filename = "#{__dirname}/../node_modules/#{name}.coffee.md"
  console.log 'filename', filename
  fs.readFile filename, 'utf8', (err, content) ->
    return next err if err
    srcmd = md.render content
    res.render 'module.jade', title: 'Express', srcmd: srcmd

app.get /.*/, (req, res, next) ->
  dirname = path.join params.public, path.dirname req.url
  basename = path.basename req.url
  # urlname = if path.extname(req.url) is '.html' then "#{path.basename(req.url, '.html')}.#{params.engine}" else req.url
  fs.readdir dirname, (err, files) ->
    return next() if err
    jadename = basename.split('.').slice(0, -1).join('.') + '.jade'
    return do_jade path.join(dirname, jadename) if jadename in files
    mdname = basename.split('.').slice(0, -1).join('.') + '.coffee.md'
    return do_md path.join(dirname, mdname) if mdname in files
    fs.stat path.join(dirname, basename), (err, stat) ->
      return next() if err
      if stat.isFile()
        res.render url, title: 'Express'
      else if stat.isDirectory()
        fs.readdir path.join(dirname, basename), (err, files) ->
          jadename = 'index.jade'
          return do_jade path.join(dirname, 'index.jade') if jadename in files
          return do_md dirname + '/index.coffee.md' if jadename in files
          next()
  do_jade = (filename) ->
    res.render filename, title: 'Express'
  do_md = (filename) ->
    fs.readFile filename, 'utf8', (err, content) ->
      return next err if err
      srcmd = md.render content
      res.render 'module.jade', title: 'Express', srcmd: srcmd

app.use serve_index "#{params.public}"

if process.env.NODE_ENV is 'development'
  app.use errorhandler()

server.listen params.port
module.exports = server
