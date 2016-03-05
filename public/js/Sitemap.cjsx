
require './Sitemap.styl'
React = require 'react'

ModuleItem = React.createClass
  render: ->
    <a className="item" href={this.props.module.href}>{this.props.module.name}</a>

Sitemap = React.createClass
  render: ->
    groups = for name, module of @props.data
      <ModuleItem key={name} module={module} />
    <div className="sitemap ui left vertical inverted sidebar menu uncover">
      <a className="item" href="/"><i className="home icon" /><span className="text">Home</span></a>
      <div className="item">
        <i className="student icon" />
        <span className="ui inverted header">Documentation</span>
        <div className="menu">
          <a className="item" href="/documentation/introduction">What is ryba</a>
          <a className="item" href="/documentation/getting_started">Getting Started</a>
          <a className="item" href="/documentation/operator">Guide for Operators</a>
        </div>
      </div>
      <div className="item">
        <i className="student icon" />
        <span className="ui inverted header">Modules</span>
        <div className="menu">
          {groups}
        </div>
      </div>
    </div>

module.exports = Sitemap
