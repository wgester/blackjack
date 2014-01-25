class window.Chips extends Backbone.Collection
  model: Chip
  localStorage: new Backbone.LocalStorage('chip_store')
  initialize: ->
    @fetch()
    if @length isnt 1
      chip = new Chip({chipVal: 100})
      @add(chip)
