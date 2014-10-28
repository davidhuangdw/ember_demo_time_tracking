tp = new Track.TimeParser()
af = new Track.ActivityField()
update_model = (model,attributes) ->
  model.set(k, v) for k,v of attributes


Track.ActivityController = Ember.ObjectController.extend Track.FieldsInput.CtrlMixin,
  needs: ['application','activities']

  showConfirm: (->false).property()
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
      update_model @get('model'), af.activity_from_fields @get('fields')
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
      new_record = @store.createRecord('activity', af.activity_from_fields @get('fields'))
      promise = new_record.save().then (record)=>
          @set 'model', record    #in order to change 'confirmId'
          console.log(record.id)
          @get('controllers.activities.model').addObject(record)
        .catch (error)=>
          new_record.deleteRecord()
          throw error
      @tryFinish promise

    confirmDelete: ->
      @set 'showConfirm', true

