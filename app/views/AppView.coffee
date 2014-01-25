class window.AppView extends Backbone.View

  className: 'appView'

  template: _.template '
    <div class="score-container"></div>
    <div class="betCounter"></div>
    <button class="hit-button" disabled>Hit</button> <button class="stand-button" disabled>Stand</button>
    <div class="player-hand-container selected"></div>
    <div class="dealer-hand-container"></div>
      
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('dealerHand').stand()
    "click .reset":  -> @clearGame()

  initialize: -> 
    @render()
    @listenTo @model.get('dealerHand'), 'gameover', @declareWinner
    @listenTo @model.get('playerHand'), 'gameover', @declareWinner

  declareWinner: ->
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
    $('.score-container').toggle()
    @collectWinnings() if winner is "Player"

  collectWinnings: ->
    chipMod =  @model.get('chips').at(0)
    betNo = parseInt $('.betno').text()
    console.log betNo
    chipVal = chipMod.get('chipVal')
    chipMod.set('chipVal', chipVal + (2 * betNo))

  resetGame: ->
    @$('button').hide()
    $resetGame = $('<button class="reset">Reset Game</button>')
    @$('.score-container').append($resetGame)

  clearGame: ->
    @model.get('chips').at(0).save()
    @model.destroy()
    @model = new App()
    @initialize()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.betCounter').html new ChipView(model: @model.get('chips').at(0)).el
