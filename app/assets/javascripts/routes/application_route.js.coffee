Track.ApplicationRoute = Ember.Route.extend
  setupController: (controller,model)->
    @_super(controller, model)
    controller.set 'types',@store.findAll('type')