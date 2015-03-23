parameters = require 'parameters'

module.exports = parameters
  name: 'app'
  description: 'Ryba HTTP server'
  options: [
    name: 'engine', shortcut: 'e'
    description: 'Rendering engine (eg jade)'
  ,
    name: 'port', shortcut: 'p'
    description: 'Server port'
  ,
    name: 'public', shortcut: 'd'
    description: 'Directory storing files to serve'
    required: true
  ]

