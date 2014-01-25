class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    if @model.get('revealed')
      cardImage =  "url('cardDeck/cards/#{@model.get('rankName')}-#{@model.get('suitName')}.png')"
      @$el.css {"background-image": cardImage}
    else 
      cardImage = "url('cardDeck/card-back.png')"
      @$el.css {"background-image": cardImage}
    @$el.children().detach().end().html
    @$el.addClass 'covered' unless @model.get 'revealed'
