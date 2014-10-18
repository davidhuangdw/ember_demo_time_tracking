Track.ActivitiesNewView = Ember.View.extend
  templateName: 'activities/new'
  didInsertElement: ->

    $('.datetimepicker').datetimepicker
      format: 'HH:mm'
      pickSeconds: false
      pickDate: false
    $('.datetimepicker').keydown (e)-> e.preventDefault()
