Track.ActivityFormView = Ember.View.extend
  templateName: 'activity/form'
  preview: (-> markdown.toHTML @get('controller.fields.description') ).property('controller.fields.description')

  didInsertElement: ->
    $('.datetimepicker').datetimepicker
      format: 'HH:mm'
      pickSeconds: false
      pickDate: false
#    $('.datetimepicker').keydown (e)-> e.preventDefault()

