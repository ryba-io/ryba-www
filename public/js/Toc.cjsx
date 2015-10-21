React = require 'react'
require './Toc.styl'

Section = React.createClass
  render: ->
    anchor = '#'+this.props.anchor
    <li class="slds-list__item">
      <a className="slds-text-heading--small" href="#{anchor}">{this.props.title}</a>
    </li>

Commands = React.createClass
  render: ->
    sections = for section in this.props.sections
      <Section key={section.anchor} anchor={section.anchor} title={section.title} />
    <div className="toc sticky">
      <div className="title"><b>{this.props.title}</b></div>
      <ul className="slds-list--vertical">
        {sections}
      </ul>
    </div>



# <div className="ui close right rail">
#   <div className="ui sticky fixed top">
#     <div className="ui secondary vertical following fluid menu">
#       <div className="item">
#         <a className="title"><b>{this.props.title}</b></a>
#         <div className="content menu">
#           {sections}
#         </div>
#       </div>
#     </div>
#   </div>
# </div>


module.exports = Commands
