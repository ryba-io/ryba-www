
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

###
modules =
  by_filename: <filename: submodule>
  by_name: <name: module>
  full: [module with submodules]
module =
  name: 'Module name'
  path: 'ryba/module'
  logo: 'path/to/logo'
  status: 'stable|preview|broken'
  submodules: [
    filename: 'ryba/path/to/index'
    href: '/module/path'
    index: true|false
    title: 'Module Title'
    description: 'Module description'
    html: 'module page cntent'
  ]
###

exports.modules = (options, callback) ->
  result =
    by_name: {}
    by_filename: {}
    full: []
  modules = require './module_list'

  each modules
  .run (mod, next) ->
    result.by_name[mod.name] = mod
    mod.submodules = []

    glob "#{__dirname}/../node_modules/#{mod.path}/**/index.coffee.md", (err, filenames) ->
      return next err if err
      
      each filenames
      .run (filename, next) ->
        module = {}
        filename = /^.*node_modules\/(.*)$/.exec(filename)[1] # Remove before node_modules in path
        filename = /(.*?)\.[^/]*$/.exec(filename)[1] # Remove extension
        module.filename = filename
        module.href = "/module/#{filename}"

        # Build module's name
        if filename == "ryba/#{mod.name.toLowerCase()}/index"
          module.index = true
          module.name = "Base"
        else # Build name from filename
          module.index = false
          name = filename.split('/')
          name.splice 0, 1
          name.splice -1, 1
          module.name = capitalize name.join " "
          if name.indexOf("tools") != -1 # For tools, set base as name
            module.name = "Base"

        # Add module to submodules list
        if module.index
          mod.submodules.unshift module
        else mod.submodules.push module

        # Parse markdown
        fs.readFile "#{__dirname}/../node_modules/#{filename}.coffee.md", 'utf8', (err, source) ->
          return next err if err
          # module.source = source
          html = md.render source
          module.html = html
          $ = cheerio.load html
          $title = $('h1')
          $description = $title.next('p')
          module.title = $title.html()
          module.description = $description.html()
          next()
        result.by_filename[module.filename] = module
      .then next
  .then (err) ->
    result.full = modules
    callback err, result
