Track.TypesController = Ember.ArrayController.extend
  errorMessage: null

Track.TypeController = Ember.ObjectController.extend
  needs: ['types']
  errorMessage: (->null).property()
  transBack: ->
    @transitionToRoute 'types.index'

  actions:
    cancel: ->
      @get('model').deleteRecord()
      @transBack()
    save: -> @get('model').save().then =>
        @get('controllers.types.model').addObject @get('model')
        @transBack()
      , (error) => @set 'errorMessage', error.message
    delete: ->
      if confirm("Are you sure to delete it?")
        @get('controllers.types.model').removeObject @get('model')
        @get('model').destroyRecord().then =>
            @transBack()
          , (error) => @set 'errorMessage', error.message

