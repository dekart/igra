#= require ./animator

window.GameAnimator = class extends Animator
  movementAnimationSpeed: 300


  loops: # [StartFrame, EndFrame, Speed]
    object: {frames: [0,  3], speed: 0.2}

  constructor: (controller)->
    super(controller)

    @background_layer = new PIXI.DisplayObjectContainer()
    @object_layer = new PIXI.DisplayObjectContainer()

    @stage.addChild(@background_layer)
    @stage.addChild(@object_layer)

    @object_sprite = null

  activate: ->
    return unless super

    @.addSprites()

    @.attachRendererTo(@controller.el)

  addSprites: ->
    @background_sprite = PIXI.Sprite.fromImage(preloader.paths.background)

    @background_layer.addChild(@background_sprite)

    @object_sprite = @.createObjectSprite(@controller.object)
    @object_layer.addChild(@object_sprite)


    @sprites_added = true

  animate: =>
    unless @paused_at
      @controller.updateState()

      if @movement_animation_started and @.isMovementAnimationFinished()
        @movement_animation_started = null

        @controller.onMovementAnimationFinished()

      @.updateSpriteStates()

    super

  updateSpriteStates: ->
    return unless @sprites_added


    if @controller.object.moving_to
      if not @movement_animation_started or @.isMovementAnimationFinished()
        @object_sprite.position.x = @.objectToSceneX(sprite.source.x)
        @object_sprite.position.y = @.objectToSceneY(sprite.source.y)
      else
        progress = @.movementAnimationProgress()

        @object_sprite.position.x = @.objectToSceneX(
          @controller.object.moving_to.x +
          (1 - progress) * (@object_sprite.source.x - @controller.object.moving_to.x)
        )
        @object_sprite.position.y = @.objectToSceneY(
          @controller.object.moving_to.y +
          (1 - progress) * (@object_sprite.source.y - @controller.object.moving_to.y)
        )


  createObjectSprite: (object)->
    sprite = new PIXI.MovieClip(@.loops["object"].textures)
    sprite.animationSpeed = @.loops["object"].speed
    sprite.play()
    sprite.position.x = @.objectToSceneX(object.x)
    sprite.position.y = @.objectToSceneY(object.y)
    sprite.anchor.x = 0.5
    sprite.anchor.y = 0.5
    sprite.source = object
    sprite

  objectToSceneX: (coordinate)->
    coordinate # Offset logic goes here

  objectToSceneY: (coordinate)->
    coordinate # Offset logic goes here

  mousePositionToCanvas: (position)->
    position

  animateObjectMovement: ()->
    @movement_animation_started = Date.now()

    # Animation logic start

  isMovementAnimationFinished: ->
    Date.now() - @movement_animation_started > @.movementAnimationSpeed


  movementAnimationProgress: ->
    (Date.now() - @movement_animation_started) / @.movementAnimationSpeed


  isBlockingAnimationInProgress: ->
    @movement_animation_started

