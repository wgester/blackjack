class window.ChipsView extends Backbone.View

  className: 'chip'

  template: _.template 
  '<button class="increaseBet">Up the Ante</button>
  <button class="decreaseBet">Scared?</button>
  <span class="bet"></span>
  '

  initialize: ->
    @collection.on 'change', => @render
    @render()

  render: ->
    cardImage = if @model.get('revealed')
      "url('cardDeck/cards/#{@model.get('rankName')}-#{@model.get('suitName')}.png')"
    else 
      "url('cardDeck/card-back.png')"
    @$el.children().detach().end().html
    @$el.css {"background-image": cardImage}
    @$el.addClass 'covered' unless @model.get 'revealed'
