
fs = require 'fs'
Module = require 'module'
path = require 'path'
cheerio = require 'cheerio'
glob = require 'glob'
each = require 'each'
remarkable = require 'remarkable'
md = new remarkable 'full'

status = -1 # -1 not started, 0 discovering, 1 ready
stack = []
modules = []
error = null

capitalize = (str) ->
  str.replace /\w\S*/g, (txt) ->
    txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()

exports = module.exports = (req, res, next) ->
  if status is 1
    req.modules = modules
    return next error
  stack.push next
  if status is -1
    status = 0
    exports.modules {}, (err, mods) ->
      modules = mods
      error = err
      status = 1
      for next in stack
        req.modules = modules
        next error
      stack = null

exports.modules = (options, callback) ->
  result =
    by_name: {}
    by_filename: {}
  glob "#{__dirname}/../node_modules/ryba/**/*.coffee.md", (err, filenames) ->
    return callback err if err
    each filenames
    .call (filename, callback) ->
      module = {}
      filename = /^.*node_modules\/(.*)$/.exec(filename)[1] # Remove before node_modules in path
      # ryba/ambari/agent/index.coffee.md
      name = /(.*?)\.[^/]*$/.exec(filename)[1] # Remove extension
      name = /(.*?)(\/index)?$/.exec(name)[1] # Remove extension
      module.name = name
      module.filename = filename
      module.href = "/module/#{name}"
      # # Build module's name
      # if filename == "ryba/#{mod.name.toLowerCase()}/index"
      #   module.index = true
      #   module.name = "Base"
      # else # Build name from filename
      #   module.index = false
      #   name = filename.split('/')
      #   name.splice 0, 1
      #   name.splice -1, 1
      #   module.name = capitalize name.join " "
      #   if name.indexOf("tools") != -1 # For tools, set base as name
      #     module.name = "Base"
      # # Add module to submodules list
      # if module.index
      #   mod.submodules.unshift module
      # else mod.submodules.push module
      # Parse markdown
      fs.readFile "#{__dirname}/../node_modules/#{filename}", 'utf8', (err, source) ->
        return callback err if err
        console.log "got #{__dirname}/../node_modules/#{filename}"
        html = md.render source
        module.html = html
        $ = cheerio.load html
        $title = $('h1')
        $description = $title.next('p')
        module.title = $title.html()
        module.description = $description.html()
        callback()
      result.by_filename[module.filename] = module
      result.by_name[module.name] = module
    .then (err) ->
      callback err, result
