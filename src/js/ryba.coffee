###* @jsx React.DOM ###

$().ready ->
  
  $content = $('.main.content.container')
  $section_headers = $content.children('h2')
  $follow_menu = $('#content .following.menu')

  $('#launch').click ->
    $tok = $('.left')
    $tok.sidebar('toggle')

  content = [
    { title: 'Horse', description: 'An Animal' }
    { title: 'Cow', description: 'Another Animal' }
  ]

  $('pre code[class^="language-"]')
  .each (i, block) ->
     hljs.highlightBlock block
  $('pre code:not([class]), pre code[class=""]')
  .parent()
  .wrap( "<div class='ui styled fluid accordion'></div>" )
  .before('<div class="title"><i class="dropdown icon"></i>Show Source Code</div>')
  .children('code')
  .each (i, block) ->
     hljs.highlightBlock block
     $(@).parent().toggle()

  $section_headers 
  .each (i, block) ->
    $h2 = $(@)
    text = $h2.text().replace(' ', '-').toLowerCase()
    $h2.before("<a id='#{text}' class='anchor'></a>")
  $content.find('table').addClass 'ui striped table'

  menu_toggle = ->
    $section = $(@)
    index = $section_headers.index $section
    $followSection = $follow_menu.find '.menu > .item'
    $activeSection = $followSection.eq index
    $followSection.removeClass 'active'
    $activeSection.addClass 'active'
  $section_headers.visibility
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
    # #   index = $section_headers.index $section
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

  $( window ).scroll (e) ->
    ph = $('#header .item.intro p').outerHeight(true)
    wt = $(window).scrollTop()
    # console.log ph, wt, ph * 4 - wt, Math.round ph - wt, $('#header').css 'top'
    top = if wt / 2 > ph then (Math.max ph, ph - wt / 2) else wt / 2
    $('#header')
    .css 'top', - top
    $('#header .item.logo img')
    .width("#{Math.ceil 100 - 50 * top / ph}%")
    .css 'top', Math.floor -30 + top * (-30 - 10) / (0 - ph)

  $title_container = $('.main.title .container .segment')
  $content_container = $('.main.content.container')

  $content.children('h1').addClass('ui header').appendTo($title_container.eq 0)

  $('.ui.accordion').accordion()
  $sticky = $('.ui.sticky')
  $sticky.sticky
    # context: '#content .ui.page'
    context: $content_container
    offset: 50
    # bottomOffset: 0
    pushing: true
  $sticky.sticky 'refresh'
  
  
  $.getJSON '/modules.json', (data) ->
    React.render `<Toc data={data.by_name} />`, $('.toc').get(0)
    name = /\/module\/(.*?)(\.html|\/*)$/.exec(window.location.pathname)?[1]
    return unless name
    React.render `<Commands commands={data.commands} name={name} />`, $('.commands').get(0)
    # 
    # $('.dropdown').dropdown
    #   transition: 'drop'

  # $.getJSON '/modules.json', (data) ->
  #   items = []
  #   registered = []
  #   for service, commands of data.services
  #     registered.push service
  #     module = data.by_name[service]
  #     items.push '<div class="item">'
  #     items.push '<div class="ui small inverted header">'
  #     items.push module.title
  #     items.push '</div>'
  #     items.push '<div class="menu">'
  #     modules = {}
  #     for command, mods of commands
  #       modules[mod] = true for mod in mods
  #       
  #     for module of modules
  #       module = data.by_name[module]
  #       items.push '<a class="item" href="">'
  #       items.push module.title
  #       items.push '</a>'
  #     items.push '</div>'
  #     items.push '</div>'
  #   $('.modules').html items.join ''

  $search = $('.ui.search')
  $search_items = $('.toc div.item')
  
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
