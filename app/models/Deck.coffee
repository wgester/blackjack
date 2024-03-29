class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> hand = new Hand [ @pop().flip(), @pop().flip() ], @, false

  dealDealer: -> new Hand [ @pop().flip(), @pop().flip() ], @, true
