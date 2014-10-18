Track.ActivityController = Ember.ObjectController.extend
  needs: ['activities']
  date: (->
    moment(@get 'beginAt').format('MM-DD')
  ).property('beginAt')

  details: (->
    limit=100
    desc = @get('description') || ''
    if desc.length>limit then desc[0...limit]+"..." else desc
  ).property('description')

  actions:
    save: ->
      @get('model').save().then =>
        @transitionToRoute 'activities'
    cancel: -> @transitionToRoute 'activities'
    delete: ->
      @get('model').deleteRecord()
      @get('model').save().then =>
        @get('controllers.activities.model').removeObject(@get('model'))
        @transitionToRoute 'activities'
