
Track.ActivityRoute = Ember.Route.extend Track.FieldsInput.RouteMixin,
  model: (params) ->
    @store.find 'activity', params.activity_id
  setupController: (controller, model) ->
    @_super(controller,model)
    controller.setProperties
      errorMessage: null
      showConfirm: false
      inProcess: false

