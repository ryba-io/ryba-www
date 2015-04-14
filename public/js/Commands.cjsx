
React = require 'react'
$ = require('jquery')

CommandModule = React.createClass
  render: ->
    module = this.props.module.split('/').pop()
    <div className="ui small label">
      {module}
    </div>

Command = React.createClass
  render: ->
    modules = for module in @props.modules
      <CommandModule key={module} module={module} />
    <div className="item" data-value={this.props.command}>
      {this.props.command}
      {modules}
    </div>

Commands = React.createClass
  render: ->
    commands = null
    names = @props.name.split('/')
    for i in [names.length-1..1]
      break if commands
      name = names.slice(0, i).join('/')
      commands = @props.commands[name]
      break if commands
      if i is names.length - 1
        innernames = names[i].split('_')
        for j in [innernames.length-1..1]
          innername = name+'/'+innernames.slice(0, j).join('_')
          commands = @props.commands[innername]
          break if commands
    commands = for command, modules of commands
      <Command key={command} command={command} modules={modules} />
    <div className="ui selection dropdown">
      <input name="" type="hidden" />
      <div className="default text">Available Commands</div>
      <i className="dropdown icon" />
      <div className="menu">
        {commands}
      </div>
    </div>
  componentDidMount: ->
    $(this.getDOMNode()).dropdown
      transition: 'drop'

module.exports = Commands

# React.render `<Commands />`, document.getElementById '#content-commands'
# React.render `<Commands />`, $('#content-commands').get(0)
