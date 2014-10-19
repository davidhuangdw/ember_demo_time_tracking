Track.TypesRoute = Ember.Route.extend
  model: -> @store.findAll('type')

Track.TypeRoute = Ember.Route.extend
  model: (params) -> @store.find('type', params.id)

Track.TypesNewRoute = Ember.Route.extend
  model: -> @store.createRecord('type')
  controllerName: 'type'

