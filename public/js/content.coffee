
$ = require('jquery')
require 'highlight.js/styles/default.css'
require 'highlight.js/styles/github.css'
hljs = require 'highlight.js'
require('semantic-ui/src/definitions/modules/accordion.js')
require('./content.styl')

$ ->
  $content = $('.main.content.container')
  # Highlight code example, with a language specific class
  $content.find('pre code[class^="language-"]')
  .each (i, block) ->
    hljs.highlightBlock block
  # Highlight ryba code, without a language specific class
  # Add "active" class to $('.title') and $('.content') to open the accordion
  $content.find('pre code:not([class]), pre code[class=""]')
  .parent()
  .wrap( "<div class='ui styled fluid accordion'></div>" )
  .before('<div class="title"><i class="dropdown icon"></i>Show Source Code</div>')
  .wrap( "<div class='content'></div>" )
  .children('code')
  .each (i, block) ->
    hljs.highlightBlock block
    $(@).closest('.ui.accordion').accordion()
