
/** @jsx React.DOM */
$().ready(function() {
  var $content, $content_container, $follow_menu, $search, $search_items, $section_headers, $sticky, $title_container, content, menu_toggle, search_items;
  $content = $('.main.content.container');
  $section_headers = $content.children('h2');
  $follow_menu = $('#content .following.menu');
  $('#launch').click(function() {
    var $tok;
    $tok = $('.left');
    return $tok.sidebar('toggle');
  });
  content = [
    {
      title: 'Horse',
      description: 'An Animal'
    }, {
      title: 'Cow',
      description: 'Another Animal'
    }
  ];
  $('pre code[class^="language-"]').each(function(i, block) {
    return hljs.highlightBlock(block);
  });
  $('pre code:not([class]), pre code[class=""]').parent().wrap("<div class='ui styled fluid accordion'></div>").before('<div class="title"><i class="dropdown icon"></i>Show Source Code</div>').children('code').each(function(i, block) {
    hljs.highlightBlock(block);
    return $(this).parent().toggle();
  });
  $section_headers.each(function(i, block) {
    var $h2, text;
    $h2 = $(this);
    text = $h2.text().replace(' ', '-').toLowerCase();
    return $h2.before("<a id='" + text + "' class='anchor'></a>");
  });
  $content.find('table').addClass('ui striped table');
  menu_toggle = function() {
    var $activeSection, $followSection, $section, index;
    $section = $(this);
    index = $section_headers.index($section);
    $followSection = $follow_menu.find('.menu > .item');
    $activeSection = $followSection.eq(index);
    $followSection.removeClass('active');
    return $activeSection.addClass('active');
  };
  $section_headers.visibility({
    once: false,
    offset: 160,
    onTopPassed: menu_toggle,
    onBottomPassedReverse: menu_toggle
  });
  $('.label.code').click(function() {
    return $(this).next().toggle();
  });
  $(window).scroll(function(e) {
    var ph, top, wt;
    ph = $('#header .item.intro p').outerHeight(true);
    wt = $(window).scrollTop();
    top = wt / 2 > ph ? Math.max(ph, ph - wt / 2) : wt / 2;
    $('#header').css('top', -top);
    return $('#header .item.logo img').width("" + (Math.ceil(100 - 50 * top / ph)) + "%").css('top', Math.floor(-30 + top * (-30 - 10) / (0 - ph)));
  });
  $title_container = $('.main.title .container .segment');
  $content_container = $('.main.content.container');
  $content.children('h1').addClass('ui header').appendTo($title_container.eq(0));
  $('.ui.accordion').accordion();
  $sticky = $('.ui.sticky');
  $sticky.sticky({
    context: $content_container,
    offset: 50,
    pushing: true
  });
  $sticky.sticky('refresh');
  $.getJSON('/modules.json', function(data) {
    var name, _ref;
    React.render(<Toc data={data.by_name} />, $('.toc').get(0));
    name = (_ref = /\/module\/(.*?)(\.html|\/*)$/.exec(window.location.pathname)) != null ? _ref[1] : void 0;
    if (!name) {
      return;
    }
    return React.render(<Commands commands={data.commands} name={name} />, $('.commands').get(0));
  });
  $search = $('.ui.search');
  $search_items = $('.toc div.item');
  search_items = [];
  $search_items.children('.header').each(function(i, block) {
    return search_items.push({
      title: $(this).text().toLowerCase(),
      description: '',
      index: i
    });
  });
  return $search.search({
    onSearchQuery: function(query) {
      var item, _i, _len, _results;
      if (query.length < 3) {
        return $search_items.children('.header').parent().show();
      }
      query = query.toLowerCase();
      _results = [];
      for (_i = 0, _len = search_items.length; _i < _len; _i++) {
        item = search_items[_i];
        _results.push($search_items.children('.header').eq(item.index).parent().toggle(item.title.indexOf(query) !== -1));
      }
      return _results;
    }
  });
});
