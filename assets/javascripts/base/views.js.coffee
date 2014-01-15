@MyApp.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.CompositeView extends Marionette.CompositeView

  class Views.ItemView extends Marionette.ItemView

  class Views.CollectionView extends Marionette.CollectionView
