Track.DayviewRoute = Ember.Route.extend
  model: (params)->
    date = moment(year:params.year, month:params.month-1, day:params.day)
    @set('date',date)
    @store.find "activity", from:date.toDate(), to:date.clone().add(1,'day').toDate()
  controllerName: 'activities'
  templateName: 'activities'
  setupController: (controller, model) ->
    controller.setProperties
      model:model
      date:@get('date')
