class window.AppView extends Backbone.View

  template: _.template '
    <div class="score-container"></div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('dealerHand').stand()

  initialize: -> 
    @render()
    @listenTo @model.get('dealerHand'), 'gameover', @declareWinner

  declareWinner: ->
    winner
    if @model.get('playerHand').scores()[0] > @model.get('dealerHand').scores()[0]
      winner = "Player"
    else
      winner = "Dealer"
    @$('.score-container').html "#{winner} wins!"

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
