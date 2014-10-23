
Track.ActivitiesController = Ember.ArrayController.extend
  itemController: 'activity'
  sortProperties: ['beginAt']
  sortAscending: false

  showDate: (-> @get('date').format("MMM Do ddd") ).property('date')
  go: (date)->
    @transitionToRoute '/activities' + date.format('/YYYY/MM/DD')

  actions:
    go_today: -> @go moment()
    go_prev_day: -> @go @get('date').subtract(1,'day')
    go_next_day: -> @go @get('date').add(1,'day')

