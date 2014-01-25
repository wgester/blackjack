class window.AppView extends Backbone.View

  className: 'appView'

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
    @listenTo @model.get('playerHand'), 'gameover', @declareWinner
    @$el.on "click", ".reset", => @clearGame()

  declareWinner: ->
    winner
    message = ""
    if @model.get('playerHand').scores() > 21 
      winner = "Dealer"
      message = "Player lost on a bust!"
    else if @model.get('dealerHand').scores() > 21
      winner = "Player"
      message = "Dealer lost on a bust!"
    else if @model.get('playerHand').scores() > @model.get('dealerHand').scores()
      winner = "Player"
    else
      winner = "Dealer"
    @$('.score-container').html "#{winner} wins! #{message}"
    @resetGame()
  
  resetGame: ->
    @$('button').hide()
    $resetGame = $('<button class="reset">Reset Game</button>')
    @$el.prepend($resetGame)

  clearGame: ->
    @model = new App()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
