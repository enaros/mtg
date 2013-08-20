fs = Npm.require('fs')

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