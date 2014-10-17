twoDigit = (number) ->
  str = number.toString()
  if str.length < 2 then '0'+str else str



Track.ActivityController = Ember.ObjectController.extend
  prettyDuration:((k,v)->
    if v?
      [minute, hour] = v.split(':').reverse().map((str)-> parseInt(str)||0)
      @set 'duration', moment.duration(minute,'m').add(hour,'h').asMilliseconds()
    else
      du = moment.duration @get('duration')
      "#{twoDigit du.hours()}:#{twoDigit du.minutes()}"
  ).property('duration')

  date: (->
    moment(@get 'beginAt').format('MM-DD')
  ).property('beginAt')
  beginTime: (->
    moment(@get 'beginAt').format('hh:mm')
  ).property('beginAt')
  details: (->
    limit=40
    desc = @get('description')
    if desc.length>limit then desc[0...limit]+"..." else desc
  ).property('description')