window.FinishDialogController = class extends BaseController
  className: 'finish dialog'

  @show: (args...)->
    @controller ?= new @()
    @controller.show(args...)

  constructor: ->
    super

    @overlay = $("<div class='dialog_overlay'></div>")

  show: (@map, @station)->
    @.setupEventListeners()

    @el.css(opacity: 0).appendTo('#canvas_container')

    @.render()

    @overlay.css(opacity: 0).appendTo('#game').fadeTo(400, 0.7)

    @el.fadeTo(400, 1)

    @visible = true

  close: ->
    @.unbindEventListeners()

    @overlay.detach()
    @el.detach()

    @visible = false

  render: ->
    @html(
      @.renderTemplate('finish_dialog')
    )

  setupEventListeners: ->
    @el.on('click', '.close', @.onCloseClick)

    $(document).on('keydown', @.onKeyDown)

  unbindEventListeners: ->
    @el.off('click', '.close', @.onCloseClick)

    $(document).off('keydown', @.onKeyDown)

  onCloseClick: =>
    @.close()

  onKeyDown: (e)=>
    @.close() if e.keyCode == 27

