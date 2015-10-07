
require './Sitemap.styl'
React = require 'react'

ModuleItem = React.createClass
  render: ->
    <div className="item">
      <a href={this.props.module.href} className="ui inverted small header">{this.props.module.name}</a>
    </div>

ModuleGroup = React.createClass
  render: ->
    icon = switch
      when @props.group.status == "stable" then "icon checkmark"
      when @props.group.status == "preview" then "icon warning"
      when @props.group.status == "broken" then "icon remove"
      else ""
    items = for module in @props.group.modules
      <ModuleItem key={module.name} module={module} />

    <div className="item">
      <i className={icon} />
      <span href="" className="ui small inverted header">{this.props.group.name}</span>
      <div className="modules menu">
        {items}
      </div>
    </div>

Sitemap = React.createClass
  render: ->
    groups = for mod in @props.data
      group = name: mod.name, status: mod.status, modules: mod.submodules
      <ModuleGroup key={group.name} group={group} />

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

module.exports = Sitemap
