fields_from_activity = (a) ->
  title: a.get('title')
  description: a.get('description')
  date: a.get('date')
  beginTime: a.get('beginTime')
  durationTime: a.get('durationTime')




Track.ActivityRoute = Ember.Route.extend
  model: (params) -> @modelFor('activities').find params.id
  setupController: (controller, model) ->
    @_super(controller,model)
    controller.set 'fields', fields_from_activity(model)