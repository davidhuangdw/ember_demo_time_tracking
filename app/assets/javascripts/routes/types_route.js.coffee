setup = (controller, model)->
  controller.setProperties
    model: model
    errorMessage: null

Track.TypesRoute = Ember.Route.extend
  model: -> @store.find('type')

Track.TypeRoute = Ember.Route.extend
  model: (params) -> @store.find('type', params.id)
  setupController: setup

Track.TypesNewRoute = Ember.Route.extend
  model: -> @store.createRecord('type')
  controllerName: 'type'
  setupController: setup

