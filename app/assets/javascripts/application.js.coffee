#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require moment
#= require bootstrap-datetimepicker
#= require pickers
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require track

$(document).on 'ready page:change', ->
  $('.datepicker').datetimepicker pickSeconds:false

# for more details see: http://emberjs.com/guides/application/
window.Track = Ember.Application.create()

