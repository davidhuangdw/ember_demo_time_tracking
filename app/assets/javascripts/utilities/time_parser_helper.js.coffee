twoDigit = (num) ->
  if 0 <= num <10 then "0#{num}" else num

parseTime = (str)->
  [minute, hour] = str.split(':').reverse().map((num)-> parseInt(num)||0)
  [hour,minute]

to_minutes = (str) ->
  [hour,minutes] = parseTime(str)
  hour*60 + minutes

div = (x, d) -> if d>0 then Math.floor x/d else 0

minutes_to_time = (m) -> format_time_str div(m,60),m%60
format_time_str = (hour, minute) -> "#{twoDigit hour}:#{twoDigit minute}"



class TimeParser
  add_one_day: (date) -> moment(date).add(1,'day').toDate()

  parseDate: (date, time_str) ->
    [hour,minute] = parseTime(time_str)
    moment(date).hour(hour).minute(minute).toDate()

  subtract_time_str: (to, fr) ->
    return null unless to && fr
    [fr,to] = [fr,to].map(to_minutes)
    to += 24*60 if to < fr
    minutes_to_time(to-fr)

  add_time_str: (a, b) ->
    [a,b] = [a,b].map(to_minutes)
    minutes_to_time (a+b)%(24*60)

  date_to_time_str: (date)->
    moment(date).format("HH:mm")

  duration_to_time_str: (duration) ->
    du = moment.duration duration
    minutes_to_time Math.floor du.asMinutes()

Track.TimeParser = TimeParser