Track.ApplicationRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      types: @store.findAll('type')
      cached: Ember.Object.create()

