# Add scripts to load to this array. These can be loaded remotely like jquery
# is below, or can use file paths, like 'vendor/underscore'

require.config({
  "baseUrl": "/js/vendor/",
  "shim": {
    'semantic': ['jquery.min'],
    'waypoints': ['jquery.min'],
    'waypoints-sticky': ['waypoints']
  },
  "paths": {
    'waypoints': "//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.4/waypoints"
    'waypoints-sticky': "//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.4/waypoints-sticky.min"
  }
})

js = ['jquery.min', 'waypoints', 'waypoints-sticky', 'semantic'];

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
    $waypoints = $('.main.container').find('h2').first().siblings('h2').addBack()
    $waypoints.each (index, item) ->
        $item = $(item)
        $('#sidemenu').append('<a href="#' + $item.attr('id') + '" class="item ' + colors[index % 4] + '">' + $item.text() + '</a>')
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