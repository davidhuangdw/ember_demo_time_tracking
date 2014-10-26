tp = new Track.TimeParser()
total_duration = (acts,type) ->
  acts.reduce ((sum, act) ->
    if act.get('type') == type
      sum += act.get('duration')
    else sum
  ),0


Track.ActivitiesIndexController = Ember.Controller.extend
  needs: ['application','activities']
  activities: Ember.computed.alias('controllers.activities')
  types: Ember.computed.alias('controllers.application.types')

  reports: (->
    acts = @get('activities')
    @get('types').map (type)->
      duration = total_duration(acts, type)
      {
        type: type
        duration: duration
        durationTime: tp.duration_to_time_str(duration)
      }
  ).property('types', 'activities.@each.type',
    'activities.@each.duration')
  chartData:(->
    @get('reports').map (rep)->
      value: rep.duration/60000
      color: rep.type.get('color')
      label: rep.type.get('name')
    .toArray()
  ).property('reports')

  actions:
    toggleHide: (type)-> @get('activities').send 'toggleHide',type.id
    showOnly: (type)-> @get('activities').send 'showOnly',type.id
    showAll: -> @get('activities').send 'showAll'
