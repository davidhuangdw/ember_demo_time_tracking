Track.IndexRoute = Ember.Route.extend
  beforeModel: ->
    @transitionTo "/activities"+moment().format("/YYYY/MM/DD")

