
$ = require('jquery')
require 'highlight.js/styles/default.css'
require 'highlight.js/styles/github.css'
hljs = require 'highlight.js'
require('semantic-ui/src/definitions/modules/accordion.js')

$ ->
  console.log 'back'
  $content = $('.main.content.container')
  
  $content.find('pre code[class^="language-"]')
  .each (i, block) ->
    console.log 'hightlight language'
    hljs.highlightBlock block
  
  
  # i ?= 1
  # console.log 'aaaaiiii', i++
  
  
  $content.find('pre code:not([class]), pre code[class=""]')
  .parent()
  .wrap( "<div class='ui styled fluid accordion'></div>" )
  .before('<div class="active title"><i class="dropdown icon"></i>Show Source Code</div>')
  .wrap( "<div class='active content'></div>" )
  .children('code')
  .each (i, block) ->
    console.log 'hightlight code', hljs
    hljs.highlightBlock block
    $(@).closest('.ui.accordion').accordion()

    # $(@).parent().toggle()

  # $('.ui.accordion').accordion()
