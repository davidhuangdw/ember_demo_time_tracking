# for more details see: http://emberjs.com/guides/models/defining-models/
parseTime = (str)->
  [minute, hour] = str.split(':').reverse().map((num)-> parseInt(num)||0)
  [hour,minute]

twoDigit = (number) ->
  str = number.toString()
  if str.length < 2 then '0'+str else str

parseDuration = (str) ->
  [hour,minute] = parseTime(str)
  moment.duration(minute,'m').add(hour,'h').asMilliseconds()

showDuration = (duration) ->
  du = moment.duration duration
  "#{twoDigit du.hours()}:#{twoDigit du.minutes()}"

onlyTimeFor = (pname) ->
  ((k,v)->
    if v?
      [hour,minute] = parseTime(v)
      update = moment(@get(pname)).hour(hour).minute(minute).toDate()
      @set(pname, update)
    else
      moment(@get(pname)).format("HH:mm")
  ).property(pname)







Track.Activity = DS.Model.extend
  title: DS.attr 'string'
  beginAt: DS.attr 'date'
  endAt: DS.attr 'date'
  description: DS.attr 'string'

  duration: ((k,v) ->
    if v?
      @set 'endAt',
        moment(@get('beginAt')).add(v).toDate()
    else  @get('endAt')-@get('beginAt')
  ).property('beginAt', 'endAt')


  beginTime: onlyTimeFor('beginAt')
  endTime: onlyTimeFor('endAt')
  durationTime: ((k,v)->
    if v?
      @set 'duration', parseDuration(v)
    else showDuration(@get('duration'))
  ).property('duration')
