
fs = require 'fs'

# input = process.argv[2]
# 
# console.error "Missing input argument" unless input
# console.error "Invalid input argument" unless input in ['install', 'check', 'start', 'status', 'stop']

module.exports = (command, callback) ->
  callback Error "Missing input argument" unless command
  callback Error "Invalid input argument" unless command in ['install', 'check', 'start', 'status', 'stop']
  fs.readFile "#{__dirname}/commands/#{command}", 'ascii', (err, data) ->
    return callback err if err
    data = for line in data.split /\r\n|[\n\r\u0085\u2028\u2029]/g
      continue if line.trim() is ''
      [host, label, status, time] = line.split /\s\s+/
      host: host, label: label, status: status, time: time
    callback null, data
