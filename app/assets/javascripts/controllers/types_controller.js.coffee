Track.TypesController = Ember.ArrayController.extend
  errorMessage: null

action_for = (onRecord, onArray) ->

Track.TypeController = Ember.ObjectController.extend
  needs: ['types']
  errorMessage: null
  actions:
    cancel: -> @transitionToRoute 'types'
    save: -> @get('model').save().then =>
        @set('errorMessage', null)
        @get('controllers.types.model').addObject @get('model')
        @transitionToRoute 'types'
      , (error) => @set('errorMessage', error.message)
    delete: ->
      if confirm("Are you sure to delete it?")
        @get('model').destroyRecord().then =>
            @set('errorMessage', null)
            @get('controllers.types.model').removeObject @get('model')
            @transitionToRoute 'types'
          , (error) => @set('errorMessage', error.message)

