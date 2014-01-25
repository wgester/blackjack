class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    cardImage = if @model.get('revealed')
      "url('cardDeck/cards/#{@model.get('rankName')}-#{@model.get('suitName')}.png')"
    else 
      "url('cardDeck/card-back.png')"
    @$el.children().detach().end().html
    @$el.css {"background-image": cardImage}
    @$el.addClass 'covered' unless @model.get 'revealed'
