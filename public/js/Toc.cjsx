
# .ui.close.right.rail
#   .ui.sticky.fixed.top
#     .ui.secondary.vertical.following.fluid.menu
#       .item
#         a.active.title
#           i.dropdown.icon(tabindex=0)
#           b ryba/hbase/regionserver/install
#         .active.content.menu
#             //- a.item(href="") HBase RegionServer Install
#             a.item(href="#iptables") IPTables
#             a.item(href="#service") Service
#             a.item(href="#zookeeper-jaas") Zookeeper JAAS
#             a.item(href="#configure") Configure
#             a.item(href="#opts") Opts
#             a.item(href="#metrics") Metrics
#             a.item(href="#spnego") SPNEGO
#             a.item(href="#start") Start
#             a.item(href="#check") Check
  
  
React = require 'react'
require './Toc.styl'

Section = React.createClass
  render: ->
    console.log '??', this.props
    anchor = '#'+this.props.anchor
    <a className="item" href="#{anchor}">{this.props.title}</a>

Commands = React.createClass
  render: ->
    sections = for section in this.props.sections
      console.log section.anchor
      <Section key={section.anchor} anchor={section.anchor} title={section.title} />
    <div className="ui close right rail">
      <div className="ui sticky fixed top">
        <div className="ui secondary vertical following fluid menu">
          <div className="item">
            <a className="title"><b>{this.props.title}</b></a>
            <div className="content menu">
              {sections}
            </div>
          </div>
        </div>
      </div>
    </div>


module.exports = Commands
