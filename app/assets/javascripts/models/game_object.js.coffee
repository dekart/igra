window.GameObject = class
  constructor: (@x, @y)->

  startMovingTo: (position)->
    @moving_to = {x: position.x, y: position.y}

  finishMovement: ->
    @x = @moving_to.x
    @y = @moving_to.y

    @moving_to = null