@MyApp = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    sidebarRegion: '#sidebar-region'
    contentRegion: '#content-region'

  App.reqres.setHandler "default:region", ->
    App.contentRegion

  App.on "initialize:after", ->
    @startHistory()

  return App
