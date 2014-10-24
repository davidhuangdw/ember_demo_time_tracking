withCurrentTime = (dateTime)->
  now = moment()
  dateTime.hour(now.hour()).minute(now.minute()).toDate()


Track.ActivitiesNewRoute = Ember.Route.extend
  controllerName: 'activity'
  setupController: (controller, model)->
#    @_super(controller,model)
    controller.setProperties
      model:model
      errorMessage: null
      showConfirm: false
      durationField: '00:00'
      fields:
        title: ''
        date: @controllerFor('activities').get('date')
        beginTime: moment().format("HH:mm")
        endTime: moment().format("HH:mm")
        description: ''

