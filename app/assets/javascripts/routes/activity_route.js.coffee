fields_from_activity = (a) ->
  title: a.get('title')
  description: a.get('description')
  date: a.get('date')
  beginTime: a.get('beginTime')
  durationTime: a.get('durationTime')
  type: a.get('type.content')


Track.ActivityRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'activity', params.activity_id
  setupController: (controller, model) ->
    @_super(controller,model)
    controller.setProperties
      model: model
      errorMessage: null
      showConfirm: false
      'fields': fields_from_activity(model)
