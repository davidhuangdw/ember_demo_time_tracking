Track.ActivityRowView = Ember.View.extend
  templateName: 'activity/row'
  didInsertElement: ->
    @$().hide().fadeIn()
#  willDestroyElement: ->
#    @$().slideUp(2000)

