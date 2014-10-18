Track.ActivityRoute = Ember.Route.extend
  model: (params) -> @modelFor('activities').find params.id