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
  showDuration sum


Track.ActivitiesIndexController = Ember.Controller.extend
  needs: ['application','activities']
  reports: (->
    acts = @get('controllers.activities')
    @get('controllers.application.types').map (type)->
      type: type
      durationTime: total_duration(acts, type)
  ).property('controllers.application.types',
    'controllers.activities.@each.type',
    'controllers.activities.@each.duration')
