Track.ActivitiesController = Ember.ArrayController.extend
  sortProperties: ['beginAt']
  sortAscending: false

  prettyDate: (-> @get('date').format("MMM Do ddd") ).property('date')
  actions:
    prev_day: ->
      url = '/activities' + @get('date').add(-1,'d').format('/YYYY/MM/DD')
      @transitionToRoute url
    next_day: ->
      url = '/activities' + @get('date').add(1,'d').format('/YYYY/MM/DD')
      @transitionToRoute url
    today: ->
      url = '/activities' + moment().format('/YYYY/MM/DD')
      @transitionToRoute url

