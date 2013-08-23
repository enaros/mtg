viewSet = (set) ->
  Meteor.call 'completeSet', set, (error, res) ->
    Session.set 'currentSet', res
    console.log res

Handlebars.registerHelper "card", (set, name) ->
  generateCard(set, name)

Handlebars.registerHelper "completeSet", (set) ->
  viewSet set
  _.reduce(Session.get('currentSet'), ((memo, cardName) -> memo + generateCard(set, cardName)), '')


Template.table.events
  'change #top input': (e) -> css_getclass('.card-new img').style.width = $(e.currentTarget).val() + 'px'

  'dblclick #middle .card': (e) -> 
    if $(e.currentTarget).is('.dragged')
      $(e.currentTarget).removeClass 'dragged'
      return
      
    $(e.currentTarget).toggleClass('flipped')
  
  'click .deck': -> 
    #Meteor.call 'randomCard', 'US', (error, res) ->
    res = getRandomCard()
    $('.hand').append(res)
    $('.hand div').last().draggable
      containment: '.contents'
      scroll: false
      revert: 'invalid'
      # start: -> $(this).addClass 'dragged'
      # stop: -> $(this).removeClass 'dragged'



Meteor.subscribe "cards" 

Meteor.startup ->
  console.log 'init'
  
  meny = Meny.create
    # The element that will be animated in from off screen
    menuElement: $('.meny')[0]
    # The contents that gets pushed aside while Meny is active
    contentsElement: $('.contents')[0]
    # The alignment of the menu (top/right/bottom/left)
    position: 'right'
    # The height of the menu (when using top/bottom position)
    height: 200
    # The width of the menu (when using left/right position)
    width: 260
    # Use mouse movement to automatically open/close
    mouse: true
    # Use touch swipe events to open/close
    touch: true

  $(".section").droppable
      activeClass: "ui-state-hover"
      hoverClass: "ui-state-active"
      drop: ( event, ui ) ->
        console.log 'dropped', event, ui # $( this ).addClass( "ui-state-highlight" ).find( "p" ).html( "Dropped!" )
        self = this
        
        # $(ui.draggable).animate {
        #   top: '-=' + offset.top
        #   left: '-=' + offset.left
        # }, () ->
        #   ui.draggable.appendTo(self).css {top:0, left:0 }

        offsetx = 1 + $(this).children().length * 30;

        $(ui.draggable).addClass('animate-all').on('webkitTransitionEnd', () -> 
          console.log('ended')
          ui.draggable.removeClass('animate-all').appendTo(self).css { top: '', left: '' }
          $(ui.draggable).off('webkitTransitionEnd')
        ).position({ my:'left top', at:'left+' + offsetx + ' top+1', of: $(this) })