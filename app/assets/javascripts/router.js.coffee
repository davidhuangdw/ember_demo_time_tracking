# For more information see: http://emberjs.com/guides/routing/

Track.Router.map ->
  @resource 'activities', path:'/'
  @route 'dayview', path:'/activities/:year/:month/:day'
  # @resource('posts')

