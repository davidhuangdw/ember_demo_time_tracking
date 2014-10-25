twoDigit = (num) ->
  if 0 <= num <10 then "0#{num}" else num

parseTime = (str)->
  [minute, hour] = str.split(':').reverse().map((num)-> parseInt(num)||0)
  [hour,minute]

to_minutes = (str) ->
  [hour,minutes] = parseTime(str)
  hour*60 + minutes

div = (x, d) -> if d>0 then Math.floor x/d else 0

minutes_to_time = (m) -> "#{twoDigit div m,60}:#{twoDigit m%60}"

subtract = (to, fr) ->
  return null unless to && fr
  [fr,to] = [fr,to].map(to_minutes)
  to += 24*60 if to < fr
  minutes_to_time(to-fr)

add_time = (a, b) ->
  [a,b] = [a,b].map(to_minutes)
  minutes_to_time (a+b)%(24*60)

parseDate = (old_date, str) ->
  [hour,minute] = parseTime(str)
  moment(old_date).hour(hour).minute(minute).toDate()

add_one_day= (date) -> moment(date).add(1,'day').toDate()

short = (desc,limit=100) ->
  if desc.length>limit then desc[0...limit]+"    ..." else desc
allow_break = (str, limit_row=4) ->
  rows = str.trim().split('\n').map( (s)->s+"<br>" )
  if rows.length>limit_row
    rows = rows[0...limit_row-1]
    rows.push("...<br>")
  rows.join('')

shortenDescription = (desc) ->
  allow_break short(desc || '')

activity_from_fields = (f) ->
  beginAt = parseDate f.date,f.beginTime
  endAt = parseDate f.date,f.endTime
  endAt = add_one_day(endAt) if endAt < beginAt
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
  prettyDesc: (-> markdown.toHTML @get('description')).property('description')

  getDuration: -> subtract(@get('fields.endTime'), @get('fields.beginTime'))
  durationField: (->@getDuration() ).property('fields.endTime', 'fields.beginTime')
  fields:(->{}).property()

  showConfirm: (->false).property()
  confirmId: (->"delete-"+@get('id')).property('id')

  errorMessage: (->null).property()
  inProcess: (->false).property()

  tryFinish: (promise) ->
    promise.then =>
      @transitionToRoute 'activities'
    .catch (error)=>
      @set('errorMessage', error.message)
      @set 'inProcess', false

  isBusy: ->
    return true if @get('inProcess')
    @set 'inProcess', true
    false

  actions:
    update: ->
      return if @isBusy()
      update_model @get('model'), activity_from_fields @get('fields')
      promise = @get('model').save().catch (error)=>
        @get('model').rollback()
        throw error
      @tryFinish promise

    delete: ->
      return if @isBusy()
      @get('controllers.activities.model').removeObject(@get('model'))
      @tryFinish @get('model').destroyRecord()

    create: ->
      return if @isBusy()
      new_record = @store.createRecord('activity', activity_from_fields @get('fields'))
      promise = new_record.save().then (record)=>
          @get('controllers.activities.model').addObject(record)
          @set 'model', record    #in order to change 'confirmId'
        .catch (error)=>
          new_record.deleteRecord()
          throw error
      @tryFinish promise

    confirmDelete: ->
      @set 'showConfirm', true

    setByDuration: ->
      du = @get('durationField')
      @set('fields.endTime',
        add_time(@get('fields.beginTime'), du)) if !!du
    setDuration: -> @set 'durationField',@getDuration()
