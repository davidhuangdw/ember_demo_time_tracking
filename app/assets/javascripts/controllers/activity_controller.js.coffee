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
    type: f.type
    beginAt: beginAt
    endAt: endAt
  }

update_model = (model,attributes) ->
  for k,v of attributes
    model.set(k, v)






Track.ActivityController = Ember.ObjectController.extend
  needs: ['application','activities']
  shortDesc: (-> shortenDescription @get('description')).property('description')
  confirmId: (->"delete-"+@get('id')).property('id')

  tryFinish: (promise) ->
    promise.then =>
      @transitionToRoute 'activities'
    .catch (error)=>
      @set('errorMessage', error.message)

  actions:
    update: ->
      update_model @get('model'), activity_from_fields @get('fields')
      promise = @get('model').save().catch (error)=>
        @get('model').rollback()
        throw error
      @tryFinish promise

    delete: ->
      promise = @get('model').destroyRecord().then =>
        @get('controllers.activities.model').removeObject(@get('model'))
      @tryFinish promise

    create: ->
      new_record = @store.createRecord('activity', activity_from_fields @get('fields'))
      promise = new_record.save().then (record)=>
          @get('controllers.activities.model').addObject(record)
        .catch (error)=>
          new_record.deleteRecord()
          throw error
      @tryFinish promise

    confirmDelete: ->
      @set 'showConfirm', true

