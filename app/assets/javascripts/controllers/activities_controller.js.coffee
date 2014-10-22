urlForDate = (date)->
  '/activities' + date.format('/YYYY/MM/DD')


Track.ActivitiesController = Ember.ArrayController.extend
  itemController: 'activity'
  sortProperties: ['beginAt']
  sortAscending: false

  showDate: (-> @get('date').format("MMM Do ddd") ).property('date')

  actions:
    go: (date)-> @transitionToRoute urlForDate date
    go_today: -> @send 'go', moment()
    go_prev_day: -> @send 'go', @get('date').subtract(1,'day')
    go_next_day: -> @send 'go', @get('date').add(1,'day')

