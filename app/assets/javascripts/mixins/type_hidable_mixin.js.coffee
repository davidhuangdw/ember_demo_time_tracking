Track.TypeHidable =
  CtrlMixin: Ember.Mixin.create
    needs: ['application']
    types: Ember.computed.alias('controllers.application.types')
    hideType: Ember.Object.create()

    broadcastHide: ->
      @forEach (act) => act.set 'hideRow', @get("hideType.#{act.get('type.id')}")
    setAllHide: (val) ->
      @get('types').forEach (t)=>@set("hideType.#{t.id}",val)

    actions:
      toggleHide: (type_id) ->
        k = 'hideType.' + type_id
        @toggleProperty(k)
        @broadcastHide()
      hideAll: -> @setAllHide(true); @broadcastHide()
      showAll: -> @setAllHide(false); @broadcastHide()
      showOnly: (type_id) ->
        @setAllHide(true)
        k = 'hideType.' + type_id
        @toggleProperty(k)
        @broadcastHide()

  RouteMixin: Ember.Mixin.create
    setupController: (controller, model) ->
      @_super(controller,model)
      controller.set 'hideType', Ember.Object.create()
      controller.broadcastHide()
