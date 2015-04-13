
$ = require 'jquery'
require 'nanoscroller/bin/css/nanoscroller.css'
nanoscroller = require 'nanoscroller/bin/javascripts/jquery.nanoscroller.js'

$ ->
  $anim = $('.anim')
  $anim.find('.output .nano').nanoScroller();
  $commands = $anim.find('.commands')
  $commands_a = $commands.children('a')
  $commands_a_active =  $commands.children('a.active')
  $commands_a.click (e) ->
    e.stopPropagation()
    return if $(@).hasClass 'active'
    $commands_a_active.removeClass 'active'
    $commands_a_active = $(@)
    $commands_a_active.addClass 'active'
    console.log 'click'
