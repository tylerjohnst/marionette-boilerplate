do (Marionette) ->
  _.extend Marionette.Renderer,

    lookups: ["apps/", "components/"]

    render: (template, data) ->
      path = @getTemplate(template)
      throw "Template #{template} not found!" unless path
      path(data)

    getTemplate: (template) ->
      for path in [template, template.split("/").insertAt(-1, "templates").join("/")]
        for lookup in @lookups
          full_path = lookup + path + '.html'
          return JST[full_path] if JST[full_path]
