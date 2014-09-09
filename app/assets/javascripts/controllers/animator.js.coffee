window.canvasSize = {
  width: 760
  height: 550
}

window.Animator = class
  @getRenderer: ()->
    @renderer ?= PIXI.autoDetectRenderer(canvasSize.width, canvasSize.height, null, true)

  constructor: (@controller)->
    @active = false

    @.prepareTextures()

    @stage = new PIXI.Stage(0x000000, true)
    @renderer = Animator.getRenderer()

    @last_tick = Date.now()
    @animation_requested = false

  zeroPad: (num, size)->
    s = num + ""
    s = "0" + s while s.length < size
    s

  animate: =>
    if @active
      requestAnimFrame(@.animate)

      @animation_requested = true
    else
      @animation_requested = false

    return if @paused_at

    if Date.now() - @last_tick >= 15 # 60 frames per second
      @last_tick = Date.now()

      @renderer.render(@stage)

  activate: ->
    return if @active

    @active = true
    @paused_at = null

    @.animate() unless @animation_requested

    $(document).on('dialog.opened', @.onDialogOpened)
    $(document).on('dialog.closed', @.onDialogClosed)

    true

  deactivate: ->
    return unless @active

    @active = false
    @paused_at = null

    $(document).off('dialog.opened', @.onDialogOpened)
    $(document).off('dialog.closed', @.onDialogClosed)

    true

  onDialogOpened: =>
    @paused_at = Date.now()

  onDialogClosed: =>
    @last_tick = Date.now() - 15 # Render on next frame
    @paused_at = null

  getTexture: (name)->
    @textures ?= {}

    unless @textures[name]
      unless @base_texture
        image = new Image()
        image.src = '$assetPath(art.png)'

        @base_texture = new PIXI.BaseTexture(image)

      rect = artSprite[name].frame

      @textures[name] = new PIXI.Texture(@base_texture,
        x: rect.x,
        y: rect.y,
        width: rect.w,
        height: rect.h
      )

    @textures[name]

  prepareTextures: ->
    return unless @.loops?

    for id, animation of @.loops
      animation.textures = []

      for frame in [animation.frames[0] .. animation.frames[1]]
        animation.textures.push(
          PIXI.Texture.fromFrame("#{ id }_#{ @.zeroPad(frame, 4) }.png")
        )

  detachRenderer: ->
    if @renderer.view.parentNode
      @renderer.view.parentNode.removeChild(@renderer.view)

  attachRendererTo: (selector)->
    @.detachRenderer()

    $(selector).get(0).appendChild(@renderer.view)