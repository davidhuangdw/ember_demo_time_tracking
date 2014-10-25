twoDigit = (num) ->
  if 0 <= num <10 then "0#{num}" else num

showDuration = (duration) ->
  du = moment.duration duration
  "#{twoDigit du.hours()}:#{twoDigit du.minutes()}"

total_duration = (acts,type) ->
  sum = 0
  acts.map (act) ->
    if act.get('type') == type
      sum += act.get('duration')
  sum


Track.ActivitiesIndexController = Ember.Controller.extend
  needs: ['application','activities']
  reports: (->
    acts = @get('controllers.activities')
    @get('controllers.application.types').map (type)->
      duration = total_duration(acts, type)
      {
        type: type
        duration: duration
        durationTime: showDuration(duration)
      }
  ).property('controllers.application.types',
    'controllers.activities.@each.type',
    'controllers.activities.@each.duration')
  chartData:(->
    @get('reports').map (rep)->
      value: rep.duration/60000
      color: rep.type.get('color')
      label: rep.type.get('name')
    .toArray()
  ).property('reports')

  actions:
    toggleHide: (type)-> @get('controllers.activities').send 'toggleHide',type.id
    showOnly: (type)-> @get('controllers.activities').send 'showOnly',type.id
    showAll: -> @get('controllers.activities').send 'showAll'
