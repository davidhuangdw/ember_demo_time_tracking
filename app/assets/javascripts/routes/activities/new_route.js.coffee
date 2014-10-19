withCurrentTime = (dateTime)->
  now = moment()
  dateTime.hour(now.hour()).minute(now.minute()).toDate()


Track.ActivitiesNewRoute = Ember.Route.extend
  controllerName: 'activity'
  setupController: (controller, model)->
    @_super(controller,model)
    controller.set 'fields',
      title: ''
      date: @controllerFor('activities').get('date')
      beginTime: moment().format("HH:mm")
      durationTime: "00:15"
      description: ''

