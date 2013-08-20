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
  'click .hand .card': (e) -> $(e.currentTarget).toggleClass('flipped')
  'click button': -> $('.hand .card').toggleClass('together')
  'click .deck': -> 
    Meteor.call 'randomCard', 'US', (error, res) ->
      $('.hand').append(res)