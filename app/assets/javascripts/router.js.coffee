# For more information see: http://emberjs.com/guides/routing/

Track.Router.map ->
  @resource 'activities', path:'/activities/:year/:month/:day', ->
    @route 'new', path:'new'
    @resource 'activity', path:'/activity/:id'

  # @resource('posts')

