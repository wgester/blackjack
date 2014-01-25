class window.ChipView extends Backbone.View

  className: 'chip'

  template: _.template '<span class="chipsLeft">Chips Left: <span class="chipValue"><%= chipVal %></span></span>
  <button class="increaseBet">Up the Ante</button>
  <button class="decreaseBet">Scared?</button>
  <span class="bet">Bet: <span class="betno">10</span> chips</span>
  <button class="betButton">Deal</button>
  '

  initialize: ->
    @model.on 'change', =>
      if @model.flag
        @render()
    @render()
  
  events: 
    "click .betButton": "subtractBet"
    "click .increaseBet": "incrementBet"
    "click .decreaseBet": "decrementBet"

  ## Check here for performance issues - might need .detach()
  render: ->
    @$el.html '<div class="chip"></div>'
    @$el.append @template(@model.attributes)
    @$el

  subtractBet: ->
    betVal = $(".betno").text()
    if @model.get("chipVal") - betVal >= 0
      @model.set "chipVal", @model.get("chipVal") - betVal
      @model.save()
      $('.betno').text(betVal)
      @$el.find('button').attr('disabled', true)
      $('.hit-button').attr('disabled', false)
      $('.stand-button').attr('disabled', false)
      @model.trigger "startGame"
    else
      alert "You suck! You don't have enough chips!"

  incrementBet: ->
    bet = parseInt $('.betno').text()
    $('.betno').text(bet + 10)  

  decrementBet: ->
    bet = parseInt $('.betno').text()
    if bet-10
      $('.betno').text(bet - 10) 