each frameworks, (framework) ->
  module "#{framework} - Accept",
    setup: ->
      setupFrame this, "/#{framework}.html"

  asyncTest "default accept header prefers scripts", ->
    @$.ajax
      type: 'POST'
      url: "/echo"
      success: (env) =>
        if typeof env is 'string'
          env = JSON.parse env

        if @win.Zepto?
          equal env['HTTP_ACCEPT'], "*/*;q=0.5, text/javascript, application/javascript"
        else
          equal env['HTTP_ACCEPT'], "*/*;q=0.5, text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
        start()

  asyncTest "dataType overrides default accept header", ->
    @$.ajax
      type: 'POST'
      url: "/echo"
      dataType: 'json'
      success: (env) =>
        if @win.Zepto?
          equal env['HTTP_ACCEPT'], "application/json"
        else
          equal env['HTTP_ACCEPT'], "application/json, text/javascript, */*; q=0.01"
        start()
