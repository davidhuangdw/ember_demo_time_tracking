
Track.ActivitiesController = Ember.ArrayController.extend
    needs: ['application']
    itemController: 'activity'
    sortProperties: ['beginAt']
    sortAscending: false

    types: Ember.computed.alias('controllers.application.types')
    hideType: Ember.Object.create()

    broadcastHide: ->
      @forEach (act) => act.set 'hideRow', @get("hideType.#{act.get('type.id')}")
    setAllHide: (val) ->
      @get('types').forEach (t)=>@set("hideType.#{t.id}",val)

    showDate: (-> @get('date').format("MMM Do ddd") ).property('date')
    go: (date)->
      @transitionToRoute '/activities' + date.format('/YYYY/MM/DD')

    actions:
      go_today: -> @go moment()
      go_prev_day: -> @go @get('date').subtract(1,'day')
      go_next_day: -> @go @get('date').add(1,'day')

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
