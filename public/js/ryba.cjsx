
require('./ryba.styl')
require('./home.styl')
# require 'semantic-ui/dist/themes/default/assets/fonts/icons.woff2'
require 'semantic-ui/dist/semantic.css'
require 'semantic-ui/src/definitions/behaviors/visibility.js'
require 'semantic-ui/src/definitions/modules/dropdown.js'
require 'semantic-ui/src/definitions/modules/search.js'
require 'semantic-ui/src/definitions/modules/sidebar.js'
require 'semantic-ui/src/definitions/modules/sticky.js'
require 'semantic-ui/src/definitions/modules/transition.js'

$ = require('jquery')
React = require('react')
# Commands = require('./Commands.cjsx')
Sitemap = require('./Sitemap.cjsx')
Toc = require('./Toc.cjsx')
require('./content.coffee')
require('./home.coffee')

if module.hot
  module.hot.accept ->
    console.log 'hot swap 7'

$().ready ->
  $content = $('.ryba.content.container')
  $content_h1 = $content.children('h1')
  $content_h2 = $('h2')

  $('#launch').click ->
    $sitemap = $('.left')
    $sitemap.sidebar('toggle')

  # Set anchor
  $content_h2
  .each (i, block) ->
    text = $(@).text().replace(/\s+/g, '-').toLowerCase()
    $(@).before("<a id='#{text}' class='anchor'></a>")
  # Style tables
  $content.find('table').addClass 'ui striped table'

  title = $content_h1.text()
  sections = []
  $content_h2
  .each (i, block) ->
    text = $(@).text()
    anchor = text.replace(/\s+/g, '-').toLowerCase()
    sections.push anchor: anchor, title: text
  unless $content_h1.hasClass 'no_toc'
    React.render <Toc title={title} sections={sections} />, $content.prepend('<div/>').children().get(0)
    $content.prepend $content.children().first().children().first()
    $sticky = $('.ui.sticky')
    $sticky.sticky
      # context: '#content .ui.page'
      context: $content
      offset: 50 # When in fixed position, the margin-top style
      # bottomOffset: 0
      pushing: true
    $sticky.sticky 'refresh'

  menu_toggle = ->
    $section = $(@)
    $follow_menu = $('#content .following.menu')
    index = $content_h2.index $section
    $followSection = $follow_menu.find '.menu > .item'
    $activeSection = $followSection.eq index
    $followSection.removeClass 'active'
    $activeSection.addClass 'active'
  $content_h2.visibility
    once: false
    offset: 160 # Related to the content h2 position, not exactly sure what 160 stands for
    # onTopVisible: handler.activate.accordion
    # onTopPassed: handler.activate.section
    # onBottomPassed: handler.activate.section
    # onTopPassedReverse: handler.activate.previous
    # onTopVisible: -> console.log 'onTopVisible', arguments
    # onTopPassed: -> console.log 'onTopPassed', arguments
    # # onTopPassed: ->
    # #   $section = $(@)
    # #   index = $content_h2.index $section
    # #   $followSection = $follow_menu.children '.menu > .item'
    # #   $activeSection = $followSection.eq index
    # #   $followSection.removeClass 'active'
    # #   $activeSection.addClass 'active'
    # onBottomPassed: -> console.log 'onBottomPassed'
    # onTopPassedReverse: -> console.log 'onTopPassedReverse'
    onTopPassed: menu_toggle
    onBottomPassedReverse: menu_toggle

  $('.label.code').click ->
    $(@).next().toggle()

  # Resize header on scroll
  layout_header = ->
    ph = $('#header .intro p').outerHeight(true)
    totalheight = $('#header').outerHeight(false)
    wt = $(window).scrollTop()
    top = if wt / 2 > ph then (Math.max ph, ph - wt / 2) else wt / 2
    $('#header')
    .css 'top', - top
    $('#header .logo img')
    .height("#{Math.ceil totalheight - top}px")
    .css 'top', top + 10 * (ph - top) / ph
  $( window ).scroll layout_header
  layout_header()

  # Move header from markdown to correct node
  $title_container = $('.ryba.title .container')
  $content_h1.addClass('ui header').appendTo($title_container.eq 0)

  $.getJSON '/modules.json', (data) ->
    # Render sitemap
    React.render <Sitemap data={data} />, $('.sitemap').get(0)

  $search = $('.ui.search')
  $search_items = $('.sitemap div.item')

  search_items = []
  $search_items.children('.header')
  .each (i, block) -> search_items.push
    title: $(@).text().toLowerCase()
    description: ''
    index: i
  $search.search
    onSearchQuery: (query) ->
      return if query.length < 3
        $search_items.children('.header').parent().show()
      query = query.toLowerCase()
      for item in search_items
        $search_items.children('.header')
        .eq(item.index).parent()
        .toggle(item.title.indexOf(query) isnt -1)
    # source : content
    # searchFields: [
    #   'title', 'description'
    # ]
    # searchFullText: false

# y = xmin + x * (xmin - xmax)/ (ymin - ymax)
