# for more details see: http://emberjs.com/guides/models/defining-models/

Track.Activity = DS.Model.extend
  title: DS.attr 'string'
  beginAt: DS.attr 'date'
  endAt: DS.attr 'date'
  description: DS.attr 'string'
