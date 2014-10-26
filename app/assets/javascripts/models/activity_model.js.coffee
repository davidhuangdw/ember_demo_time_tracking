# for more details see: http://emberjs.com/guides/models/defining-models/
tp = new Track.TimeParser()

Track.Activity = DS.Model.extend
  title: DS.attr 'string'
  beginAt: DS.attr 'date'
  endAt: DS.attr 'date'
  description: DS.attr 'string'
  type: DS.belongsTo 'type',async:false

  date: Em.computed.alias('beginAt')
  beginTime: (-> tp.date_to_time_str @get('beginAt')).property('beginAt')
  endTime: (-> tp.date_to_time_str @get('endAt')).property('endAt')
  duration: (->
    @get('endAt')-@get('beginAt')
  ).property('beginAt','endAt')
  durationTime: (-> tp.duration_to_time_str @get('duration')).property('duration')

  hideRow: false
  confirmId: (->"delete-"+@get('id')).property('id')





