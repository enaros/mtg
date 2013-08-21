Template.menu.events
  'change input': (e, template) ->
    file = template.find('input').files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      txt = e.target.result
      array = txt.split("\n")

      json = {}

      _.each array, (o) ->
        return if o.trim() is ''
        aux = o.trim().split(' ')
        cant = aux[0]
        delete aux[0]
        name = aux.join(' ').trim()
        json[name] = parseInt(cant)

      Meteor.call 'loadDeck', json
      $('.card:not(.deck)').remove()
      console.log json

    reader.readAsText(file)