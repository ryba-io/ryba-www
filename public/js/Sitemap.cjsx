
require './Sitemap.styl'
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
    url = "/module/#{@props.module.name}"
    <div className="item">
      <a href={url} className="ui inverted small header">{this.props.module.title}</a>
    </div>

ModuleGroup = React.createClass
  render: ->
    items = for module in @props.group.modules
      <ModuleItem key={module.name} module={module} />
    # <i className="home icon" />
    <div className="item">
      <a href="" className="ui small inverted header">{this.props.group.name}</a>
      <div className="modules menu">
      {items}
      </div>
    </div>

Sitemap = React.createClass
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
    # <div className="ui fluid search loading item">
    #   <div className="ui icon input">
    #     <input className="prompt" placeholder="Filter..." type="text" />
    #     <i className="search icon" />
    #   </div>
    # </div>
    <div className="sitemap ui left vertical inverted sidebar menu uncover">
      <a className="item" href="/"><i className="home icon" /><span className="text">Home</span></a>
      <div className="item">
        <i className="student icon" />
        <span className="ui inverted header">Quick Start</span>
        <div className="menu">
          <a className="item" href="/documentation/introduction">What is ryba</a>
          <a className="item" href="/documentation/getting_started">Getting Started</a>
        </div>
      </div>
      {groups}
    </div>
    # <div className="item">
    #   <i className="home icon" />
    #   <span className="ui inverted header">Developer’s Guide</span>
    #   <div className="menu">
    #     <a className="item" href="/documentation/internal">Understand the Internal</a>
    #     <a className="item" href="/documentation/middleware">Write your middleware</a>
    #   </div>
    # </div>
    # <div className="item">
    #   <i className="home icon" />
    #   <span className="ui inverted header">Contributor’s Guide</span>
    #   <div className="menu">
    #     <a className="item" href="/documentation/contribute">How to contribute</a>
    #     <a className="item" href="/documentation/dev_setup">Development setup</a>
    #   </div>
    # </div>

module.exports = Sitemap
