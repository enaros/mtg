fs = Npm.require('fs')

myDeck =
	'forest': 10
	'albino troll': 10
	'wild dogs': 10
	"barrin's codex": 10
	"barrin, master wizard": 10

Meteor.methods
	completeSet: (set) ->
		files = fs.readdirSync("public/img/sets/#{set}/")
		console.log files
		files = _.map files, (card) -> card.replace('.full.jpg', '')
		return files

	randomCard: (set) ->
		files = fs.readdirSync("public/img/sets/#{set}/")
		cardName = files[Math.round(Math.random() * files.length)].replace('.full.jpg', '')
		generateCard(set, cardName)

	loadDeck: (myDeck) ->
		Deck.remove({})
		console.log myDeck
		_.each myDeck, (val, key) ->
			
			cardname = new RegExp("^#{key}$", "i")
			card = Cards.findOne({name: cardname})

			delete card._id
			console.log key, val, card.manacost

			Deck.insert(_.extend card, { random: Math.random() }) for num in [1..val]
	
	randomCardFromDeck: ->
		rand = Math.random()
		console.log 'randomCardFromDeck', rand
		
		result = Deck.findOne random : { $gte : rand }
		
		if not result
			result = Deck.findOne random : { $lte : rand }

		console.log result.name
		return result