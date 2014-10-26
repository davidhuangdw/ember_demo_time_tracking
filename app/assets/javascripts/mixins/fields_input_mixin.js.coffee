tp = new Track.TimeParser()
af = new Track.ActivityField()

Track.FieldsInput =
  CtrlMixin: Ember.Mixin.create
    getDuration: ->
      tp.subtract_time_str @get('fields.endTime'), @get('fields.beginTime')
    durationField: (->@getDuration() ).property('fields.endTime', 'fields.beginTime')
    fields: {}

    actions:
      setByDuration: ->
        du = @get('durationField')
        @set('fields.endTime',
          tp.add_time_str(@get('fields.beginTime'), du)) if !!du
      setDuration: -> @set 'durationField',@getDuration()

  RouteMixin: Ember.Mixin.create
    setupController: (controller, model) ->
      @_super(controller,model)
      controller.setProperties
        fields: af.fields_from_activity(model)
        durationField: model.get('durationTime')
