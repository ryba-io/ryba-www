
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
  by_filename: <filename: module>
  by_name: <name: module>
  services: [see services]
module = 
  filename: '/abs/path/node_modules/package/path/to/module.coffee.md'
  name: 'package/path/to/module'
  title: 'Module Title'
  index: true|false


###

exports.modules = (options, callback) ->
  options = {}
  options.search = [
    "#{__dirname}/../node_modules/ryba/**/*.coffee.md"
  ]
  commands = {} # key: module name, value: list of commands
  modules = {}
  modules.filename_to_name = {}
  modules.by_name = {}
  each options.search
  .run (search, next) ->
    glob search, (err, filenames) ->
      return next err if err
      # console.log filenames
      each filenames
      .run (filename, next) ->
        # # return next() if filename is path.basename filename, '.coffee.md'
        module = {}
        module.filename = filename
        filename = /^.*node_modules\/(.*)$/.exec(filename)[1]
        # console.log filename
        # module.packagename = filename
        filename = /(.*?)\.[^/]*$/.exec(filename)[1]
        if 'index' is path.basename filename
          filename = path.dirname filename
          module.index = true
        module.name = filename
        modules.filename_to_name[module.filename] = module.name
        modules.by_name[module.name] = module
        # Find commands
        middlewares = require module.filename
        if Array.isArray middlewares
          for middleware in middlewares
            continue unless middleware.commands
            commands[module.name] ?= {}
            cmds = middleware.commands
            cmds = [cmds] unless Array.isArray cmds
            for cmd in cmds
              commands[module.name][cmd] ?= {}
              mods = middleware.modules
              mods = [mods] unless Array.isArray mods
              for mod in mods
                commands[module.name][cmd][mod] ?= true
        # Parse markdown
        fs.readFile module.filename, 'utf8', (err, source) ->
          return next err if err
          module.source = source
          html = md.render source
          module.html = html
          $ = cheerio.load html
          title = $('h1').html()
          module.title = title
          next()
      .then next
  .then (err) ->
    for name, cmds of commands
      # commands[name] = []
      for cmd, mods of cmds
        commands[name][cmd] = []
        for mod in Object.keys mods
          commands[name][cmd].push mod
    # console.log commands
    modules.commands = commands
    # for _, module of modules.by_name
    #   # Find dependencies
    #   middlewares = require module.filename
    #   if Array.isArray middlewares
    #     for middleware in middlewares
    #       mods = middleware.modules
    #       continue unless mods
    #       mods = [mods] unless Array.isArray mods
    # modules.services = exports.services modules
    callback err, modules

###
Return an object similar to

```json
{
  'ryba/zookeeper/server': {
    check: [ 'ryba/zookeeper/server_check' ],
    install: [
      'ryba/zookeeper/server_install',
      'ryba/zookeeper/server_start',
      'ryba/zookeeper/server_check' ],
     start: [ 'ryba/zookeeper/server_start' ],
     status: [ 'ryba/zookeeper/server_status' ],
     stop: [ 'ryba/zookeeper/server_stop' ] }
  }
}
```
###
exports.services = (modules) ->
  services = {}
  for filename, meta of modules.by_filename
    module = require filename
    continue unless Array.isArray module
    for middleware in module
      commands = middleware.commands
      commands = [commands] if typeof commands is 'string'
      continue unless commands?.length
      services[meta.name] ?= {}
      for command in commands
        modules = middleware.modules
        modules = [modules] if typeof modules is 'string'
        services[meta.name][command] = modules
  services
