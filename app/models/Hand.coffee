class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> 
    @add(@deck.pop()).last()
    if @scores() > 21
      @trigger 'gameover'

  stand: -> 
    @at(0).flip()
    @autohit()
    $('.dealer-hand-container').toggleClass "selected"
    $('.player-hand-container').toggleClass "selected"


  autohit: ->
    if @scores() < 17
      @hit()
      @autohit()
    else if @scores() <= 21
      @trigger 'gameover'


  scores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1 and card.get 'revealed' 
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce
      if score + 10 <= 21 then score + 10 else score
    else
      score