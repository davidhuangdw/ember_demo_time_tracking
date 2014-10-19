# For more information see: http://emberjs.com/guides/routing/

Track.Router.reopen
  rootURL: '/app/'

Track.Router.map ->
  @resource 'activities', path:'/activities/:year/:month/:day', ->
    @route 'new', path:'new'
    @resource 'activity', path:'/activity/:id'
  @resource 'types', ->
    @route 'new', path: 'new'
    @resource 'type', path:'/types/:id', ->
      @route 'edit'

  # @resource('posts')

