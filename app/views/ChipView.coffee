class window.ChipView extends Backbone.View

  className: 'chip'

  template: _.template '<button class="increaseBet">Up the Ante</button>
  <button class="decreaseBet">Scared?</button>
  <span class="bet">Bet: <%= chipVal %> chips</span>
  '

  initialize: ->
    @model.on 'change', => @render
    @render()

  ## Check here for performance issues - might need .detach()
  render: ->
    @$el.append @template(@model.attributes)
    @$el
    console.log(@model)