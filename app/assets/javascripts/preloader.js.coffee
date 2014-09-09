#= require art

window.Preloader = class
  @paths:
    logo: '$assetPath(logo.jpg)'
    art: '$assetPath(art.png)'

  manifest:
    for key, path of @.paths
      { src: path }

  constructor: (@callback)->
    @.paths = @.constructor.paths

    loader = new createjs.LoadQueue()
    loader.onComplete = @.onComplete
    loader.onFileLoad = @.onProgress
    loader.loadManifest(@.manifest)

  onComplete: (args...)=>
    @.fillTextureCache(@.paths.art, artSprite)

    @callback.call()

  fillTextureCache: (image, frames)->
    texture = PIXI.Texture.fromImage(image).baseTexture

    for key, frame of frames
      rect = frame.frame

      PIXI.TextureCache[key] = new PIXI.Texture(texture,
        x: rect.x,
        y: rect.y,
        width: rect.w,
        height: rect.h
      )

  onProgress: (args...)=>
    @total_files ?= @.manifest.length
    @loaded ?= 0
    @loaded += 1

    $('#preloader .progress').css('width', "#{ (@loaded / @total_files) * 100 }%")
