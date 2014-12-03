#= require ./game_animator

window.GameController = class extends BaseController
  className: 'game_screen'

  constructor: ->
    super

    @mouse_position = {x: 0, y: 0}

    @animator = new GameAnimator(@)

    @object = new GameObject(495, 350)

  show: ->
    @.setupEventListeners()

    @.render()

  setupEventListeners: ->
    $(document).on('keydown', @.onKeyDown)
    $(document).on('keyup', @.onKeyUp)

    @el.on('mousedown touchstart', 'canvas', @.onTouchStart)
    @el.on('mousemove touchmove', 'canvas', @.onTouchMove)
    @el.on('mouseup touchend', 'canvas', @.onTouchEnd)

  render: ->
    @animator.deactivate()

    @el.appendTo('#game')

    @animator.activate()

  updateState: ->
    # Logic goes here

  updateMousePosition: (event)->
    touchpoint = if event.originalEvent.touches? then event.originalEvent.touches[0] else event

    if touchpoint
      @canvas_offset ?= $(@animator.renderer.view).offset()

      @mouse_position.x = touchpoint.clientX - @canvas_offset.left
      @mouse_position.y = touchpoint.clientY - @canvas_offset.top

  onTouchStart: (e)=>
    e.preventDefault()

    return if @animator.isBlockingAnimationInProgress()

    @.updateMousePosition(e)

    # Logic goes here

  onTouchMove: (e)=>
    e.preventDefault()

    return if @animator.isBlockingAnimationInProgress()

    @.updateMousePosition(e)

    # Logic goes here

  onTouchEnd: (e)=>
    e.preventDefault()

    return if @animator.isBlockingAnimationInProgress()

    @.updateMousePosition(e)

    # Logic goes here

    @object.startMovingTo(@animator.mousePositionToCanvas(@mouse_position))

    @animator.animateObjectMovement()

  onMovementAnimationFinished: ->
    # Logic goes here

    @object.finishMovement()


  finish: ->
    @animator.deactivate()

    alert('Done!')

