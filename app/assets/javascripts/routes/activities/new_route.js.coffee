withCurrentTime = (dateTime)->
  now = moment()
  dateTime.hour(now.hour()).minute(now.minute()).toDate()


Track.ActivitiesNewRoute = Ember.Route.extend
  setupController: (controller, model)->
    date = withCurrentTime @controllerFor('activities').get('date')
    controller.set 'model',
      @store.createRecord 'activity', title:'', beginAt:date, endAt:date, description:''

