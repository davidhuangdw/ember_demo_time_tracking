Track.ApplicationRoute = Ember.Route.extend
  model: ->
    Ember.RSVP.hash
      types: @store.findAll('type')
      cached: Ember.Object.create()

#  setupController: (controller,model)->
#    console.log('setup controller')
#    @_super(controller, model)
#    controller.setProperties
#      types: @store.findAll('type')
#      cached: Ember.Object.create()
