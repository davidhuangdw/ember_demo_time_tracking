# for more details see: http://emberjs.com/guides/models/defining-models/
parseTime = (str)->
  [minute, hour] = str.split(':').reverse().map((num)-> parseInt(num)||0)
  [hour,minute]

parseDate = (old_date, str) ->
  [hour,minute] = parseTime(str)
  moment(old_date).hour(hour).minute(minute).toDate()

addDuration= (fr,duration) ->
  moment(fr).add(duration).toDate()

parseDuration = (str) ->
  [hour,minute] = parseTime(str)
  moment.duration(hour,'hour').
    add(minute,'minute').asMilliseconds()

shortenDescription = (desc) ->
  limit=100
  desc ||= ''
  if desc.length>limit then desc[0...limit]+"..." else desc

activity_from_fields = (f) ->
  beginAt = parseDate f.date,f.beginTime
  endAt = addDuration beginAt, parseDuration(f.durationTime)
  {
    title: f.title
    description: f.description
    beginAt: beginAt
    endAt: endAt
  }

update_model = (model,attributes) ->
  for k,v of attributes
    model.set(k, v)






Track.ActivityController = Ember.ObjectController.extend
  needs: ['activities']
  errorMessage: null
  shortDesc: (-> shortenDescription @get('description')).property('description')

  actions:
    cancel: -> @transitionToRoute 'activities'
    update: ->
      update_model @get('model'), activity_from_fields @get('fields')
      @get('model').save().then =>
          @set('errorMessage', null)
          @transitionToRoute 'activities'
        ,
          (error) => @set('errorMessage', error.message)
    delete: ->
      if confirm("Are you sure to delete it?")
        @get('model').deleteRecord()
        @get('model').save().then =>
          @get('controllers.activities.model').removeObject(@get('model'))
          @transitionToRoute 'activities'
    create: ->
      @store.createRecord('activity', activity_from_fields @get('fields'))
      .save().then (record)=>
          @get('controllers.activities.model').addObject(record)
          @set('errorMessage', null)
          @transitionToRoute 'activities'
        ,
          (error) => @set('errorMessage', error.message)


