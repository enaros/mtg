@generateCard = (set, name) ->
  if name in ['Mountain','Forest','Swamp','Plains','Island']
  	name += Math.ceil(Math.random() * 4)

  "<div class='card' style='background-image:url(\"img/sets/#{set}/#{escape(name)}.full.jpg\")'></div>"

@getRandomCard = () ->
	d = Deck.find().fetch()
	card = d[Math.round(Math.random() * d.length)]
	Deck.remove(card._id)
	generateCard 'US', card.name