Track.ActivitiesNewController = Ember.ObjectController.extend
  needs: ['activities']
  actions:
    create: ->
      console.log @get('beginAt')
      console.log @get('endAt')
      console.log @get('durationTime')
      @get('model').save().then =>
        @get('controllers.activities.model').addObject(@get('model'))
        @transitionToRoute 'activities'
    cancel: ->
      @get('model').deleteRecord()
      @transitionToRoute 'activities'

