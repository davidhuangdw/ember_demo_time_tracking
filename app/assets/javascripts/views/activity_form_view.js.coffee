Track.ActivityFormView = Ember.View.extend
  templateName: 'activity/form'
  didInsertElement: ->
    $('.datetimepicker').datetimepicker
      format: 'HH:mm'
      pickSeconds: false
      pickDate: false
    $('.datetimepicker').keydown (e)-> e.preventDefault()
