# Add scripts to load to this array. These can be loaded remotely like jquery
# is below, or can use file paths, like 'vendor/underscore'

require.config({
  "baseUrl": "/js/vendor/",
  "shim": {
    'semantic': ['jquery']
    'waypoints': ['jquery']
    'waypoints-sticky': ['waypoints']
    'jappix': ['jquery']
  },
  "paths": {
    'jquery': "//cdnjs.cloudflare.com/ajax/libs/jquery/1.8.3/jquery.min"
    'semantic': "//cdnjs.cloudflare.com/ajax/libs/semantic-ui/0.16.1/javascript/semantic.min"
    'waypoints': "//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.4/waypoints"
    'waypoints-sticky': "//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.4/waypoints-sticky.min"
  }
})

js = ['piwik', 'jquery', 'waypoints', 'waypoints-sticky', 'semantic', 'jappix'];

# this will fire once the required scripts have been loaded
require js, ->
  $ ->
    #
    # Set currently active main nav item
    # FIXME hacky as hell
    # (latest roots with path variable now released)
    #

    area = window.location.pathname.match(/\/(.+)\//)
    if area
      $("header a.#{area[1]}").addClass("active")
    else
      $("header a.home").addClass("active")

    # $("header a.home").addClass("active")
    
    # Integrate markdown with semantic-ui
    $("h1:not(.header)").addClass("ui header huge")
    $("h2:not(.header)").addClass("ui header large")
    $("h3:not(.header)").addClass("ui header medium")
    $("h4:not(.header)").addClass("ui header small")
    $("h5:not(.header)").addClass("ui header tiny")
    $("h6:not(.header)").addClass("ui header tiny")
    $("ul:not(.ui.list)").addClass("ui list")
    $("blockquote:not(.ui.message)").addClass("ui message")
    colors     = ['teal', 'blue', 'orange', 'green']
    $peek      = $('.peek')
    $waypoints = $('.main.container').find('h2, h3')
    if $waypoints.length > 20
      $waypoints = $('.main.container').find('h2')
    # $h2 = $('.main.container').find('h2')
    # $h3 = $('.main.container').find('h3')
    # if $h2.length
    #   $waypoints = $h2.first().siblings('h2').addBack()
    # if $h3.length
    #   $waypoints = $h3.first().siblings('h3').addBack()
    $waypoints.each (index, item) ->
        $item = $(item)
        tag = $item.get(0).tagName.toLowerCase()
        sub = 'sub' if tag == 'h3'
        $('#sidemenu').append('<a href="#' + $item.attr('id') + '" class="' + ['item', sub, colors[index % 4], $item.attr('id')].join(' ') + '">' + $item.text() + '</a>')
    $('#sidemenu a.item').first().addClass('active')
    $peek.waypoint('sticky');
    $('.peek a.item').click ->
        $body     = $('html, body')
        $header   = $(this)
        $menu     = $header.parent()
        $group    = $menu.children()
        $headers  = $group.add( $group.find('.menu .item') )
        $waypoint = $waypoints.eq( $group.index( $header ) )
        offset    = $waypoint.offset().top - 60;
        if !$header.hasClass('active')
          $body
            .stop()
            .one 'scroll', ->
              $body.stop();
            .animate({
              scrollTop: offset
            }, 500)
            .promise()
              .done ->
                $headers
                  .removeClass('active')
                $header
                  .addClass('active')
                $waypoint
                  .css('color', $header.css('border-right-color'))
                $waypoints
                  .removeAttr('style')


    # $('#spatial-and-temporal-what-').waypoint ->
    $('.main.container').find('h2, h3, h4').waypoint ->
      id = $(this).attr('id')
      sideitem = $("#sidemenu ." + id)
      if sideitem.length > 0
        $("#sidemenu .item").removeClass('active')
        sideitem.addClass('active')


    # Contribute button
    $("#contribute").click ->
      $(".getting-involved").click()