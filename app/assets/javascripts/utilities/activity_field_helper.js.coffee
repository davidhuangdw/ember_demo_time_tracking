tp = new Track.TimeParser()

class ActivityField
  fields_from_activity: (a) ->
    title: a.get('title') || ''
    description: a.get('description') || ''
    date: a.get('date')
    beginTime: a.get('beginTime')
    endTime: a.get('endTime')
    type: a.get('type')
  activity_from_fields: (f) ->
    beginAt = tp.parseDate f.date,f.beginTime
    endAt = tp.parseDate f.date,f.endTime
    endAt = tp.add_one_day(endAt) if endAt < beginAt
    {
      title: f.title
      description: f.description
      type: f.type
      beginAt: beginAt
      endAt: endAt
    }


Track.ActivityField = ActivityField
