# for more details see: http://emberjs.com/guides/models/defining-models/
showTime = (date)->
  moment(date).format("HH:mm")

twoDigit = (num) ->
  if 0 <= num <10 then "0#{num}" else num

showDuration = (duration) ->
  du = moment.duration duration
  "#{twoDigit du.hours()}:#{twoDigit du.minutes()}"





Track.Activity = DS.Model.extend
  title: DS.attr 'string'
  beginAt: DS.attr 'date'
  endAt: DS.attr 'date'
  description: DS.attr 'string'
  type: DS.belongsTo 'type',async:false

  hideRow: false
  date: Em.computed.alias('beginAt')
  beginTime: (-> showTime @get('beginAt')).property('beginAt')
  endTime: (-> showTime @get('endAt')).property('endAt')
  duration: (->
    @get('endAt')-@get('beginAt')
  ).property('beginAt','endAt')
  durationTime: (-> showDuration @get('duration')).property('duration')




