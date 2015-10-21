
$ = require 'jquery'
# require 'nanoscroller/bin/css/nanoscroller.css'
# nanoscroller = require 'nanoscroller/bin/javascripts/jquery.nanoscroller.js'

$ ->
  $anim = $('.anim')
  $nano = $anim.find('.output .nano')
  $content = $anim.find('.nano-content')
  $commands = $anim.find('.commands')
  $commands_a = $commands.children('a')
  $commands_a_active =  $commands.children('a.active')
  $commands_a.click (e) ->
    e.stopPropagation()
    return if $(@).hasClass 'active'
    $commands_a_active.removeClass 'active'
    $commands_a_active = $(@)
    $commands_a_active.addClass 'active'
    command = $(@).text().toLowerCase()
    $.getJSON "/command/#{command}.json", (data) ->
      html = []
      for line in data
        html.push "<tr><td>#{line.host}</td><td>#{line.label}</td><td class='status'>#{line.status}</td><td>#{line.time}</td></tr>"
      html = "<table>#{html.join ''}</table>"
      $content.html html
      # $nano.nanoScroller(scroll: 'bottom')
      $td = $content.find('td')
      $content.scrollTop 0
      start = ->
        $anim = $content.stop().animate
          'scrollTop': $td.last().get(0).offsetTop
        , $td.size()*100, 'linear'
      $content.mouseenter ->
        $anim.stop()
      $content.mouseleave ->
        start()
      start()
  $commands_a.first().trigger 'click'
  if window.location.pathname == '/'
    $('.main.title').css 'padding-top', '0'
