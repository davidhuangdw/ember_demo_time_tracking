range_from_date = (date) ->
  [date.toDate(), date.clone().add(1,'day').toDate()]

activity_in_range = (from, to) ->
  (activity) ->
    day = activity.get('beginAt')
    from <= day < to




Track.ActivitiesRoute = Ember.Route.extend
  model: (params)->
    date = moment(year:params.year, month:params.month-1, day:params.day)
    @set('date',date)

    [from,to] = range_from_date(date)
    cached = @modelFor('application').cached
    if cached.get("#{date}")
      @store.filter 'activity', activity_in_range(from,to)
    else
      cached.set("#{date}",true)
      @store.find 'activity', from:from, to:to

  setupController: (controller, model) ->
    controller.setProperties
      model:model
      date:@get('date')
