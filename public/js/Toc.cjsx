
require '../css/toc.styl'
React = require 'react'

hash = (s) ->
  s.split("").reduce (a,b) ->
    a = ((a<<5)-a) + b.charCodeAt(0)
    a&a
  , 0              

keys = {}
gkeys = {}

ModuleItem = React.createClass
  render: ->
    url = "/module/#{@props.module.name}.html"
    <div className="item">
      <a href={url} className="ui inverted small header">{this.props.module.title}</a>
    </div>

ModuleGroup = React.createClass
  render: ->
    items = for module in @props.group.modules
      <ModuleItem key={module.name} module={module} />
    <div className="item">
      <i className="home icon" />
      <a href="" className="ui small inverted header">{this.props.group.name}</a>
      <div className="modules menu">
      {items}
      </div>
    </div>

Toc = React.createClass
  render: ->
    groups = {}
    items = for name, module of @props.data
      group = if module.index then name else name.split('/').slice(0,-1).join('/')
      groups[group] ?= []
      groups[group].push module
    groups = for name, modules of groups
      continue if modules.length is 0
      group = name: name, modules: modules
      <ModuleGroup key={group.name} group={group} />
    <div className="toc ui left vertical inverted sidebar menu uncover">
      <div className="ui fluid search loading item">
        <div className="ui icon input">
          <input className="prompt" placeholder="Filter..." type="text" />
          <i className="search icon" />
        </div>
      </div>
      <a className="item"><i className="home icon" /><span className="text">Home</span></a>
      {groups}
    </div>
  
module.exports = Toc
