urlForDate = (date)->
  '/activities' + date.format('/YYYY/MM/DD')


Track.ActivitiesController = Ember.ArrayController.extend
  sortProperties: ['beginAt']
  sortAscending: false

  showDate: (-> @get('date').format("MMM Do ddd") ).property('date')

  actions:
    go_today: -> @transitionToRoute urlForDate moment()
    go_prev_day: -> @transitionToRoute urlForDate @get('date').subtract(1,'day')
    go_next_day: -> @transitionToRoute urlForDate @get('date').add(1,'day')

