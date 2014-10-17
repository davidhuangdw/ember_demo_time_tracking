Track.ActivitiesController = Ember.ArrayController.extend
  sortProperties: ['beginAt']
  sortAscending: false

  prettyDate: (-> @get('date').format("MMM Do ddd") ).property('date')
  prev_day: (-> @get('date').subtract(1,'day')).property('date')
  next_day: (-> @get('date').add(1,'day')).property('date')
  actions:
    transToDate: (date=moment())->
      @transitionToRoute '/activities' + date.format('/YYYY/MM/DD')

