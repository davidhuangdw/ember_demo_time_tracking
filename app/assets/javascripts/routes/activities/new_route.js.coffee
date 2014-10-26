Track.ActivitiesNewRoute = Ember.Route.extend
  controllerName: 'activity'
  setupController: (controller, model)->
    @_super(controller,model)
    controller.setProperties
      errorMessage: null
      showConfirm: false
      inProcess: false
      durationField: '00:00'
      fields:
        title: ''
        date: @controllerFor('activities').get('date')
        beginTime: moment().format("HH:mm")
        endTime: moment().format("HH:mm")
        description: ''

