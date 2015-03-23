###* @jsx React.DOM ###

CommandModule = React.createClass
  render: ->
    `<div className="ui small label">
      {this.props.name}
    </div>`

Command = React.createClass
  render: ->
    `<div className="item" data-value={this.props.command}>
      {this.props.command}
    </div>`

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
    return false unless commands
    
    commands = for command in commands
      `<Command key={command} command={command} />`
    `<div className="ui selection dropdown">
      <input name="" type="hidden" />
      <div className="default text">Available Commands</div>
      <i className="dropdown icon" />
      <div className="menu">
        {commands}
      </div>
    </div>`
  componentDidMount: ->
    # console.log 'ready', $(this.getDOMNode()).find('.dropdown').get(0)
    $(this.getDOMNode()).dropdown
      transition: 'drop'

# React.render `<Commands />`, document.getElementById '#content-commands'
# React.render `<Commands />`, $('#content-commands').get(0)
