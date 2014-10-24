fields_from_activity = (a) ->
  title: a.get('title')
  description: a.get('description')
  date: a.get('date')
  beginTime: a.get('beginTime')
  endTime: a.get('endTime')
  type: a.get('type')


Track.ActivityRoute = Ember.Route.extend
  model: (params) ->
    @store.find 'activity', params.activity_id
  setupController: (controller, model) ->
    @_super(controller,model)
    controller.setProperties
      model: model
      errorMessage: null
      showConfirm: false
      inProcess: false
      fields: fields_from_activity(model)
      durationField: model.get('durationTime')
