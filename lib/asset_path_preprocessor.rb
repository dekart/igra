class AssetPathPreprocessor < Sprockets::Processor
  IMAGE_PATH_REGEXP = /\$assetPath\(([^\)]+?)\)/m

  SPRITE_PATH_REGEXP = /\$assetSpritePath\(([^\)]+?)\)/m

  def evaluate(context, locals)
    # Images

    while match = data.match(IMAGE_PATH_REGEXP)
      data.sub!(IMAGE_PATH_REGEXP, "%s" % context.image_path(match[1]))
    end

    # Sprites

    while match = data.match(SPRITE_PATH_REGEXP)
      data.sub!(SPRITE_PATH_REGEXP, "%s" % sprite_url(match[1]))
    end

    data
  end

  protected

  def sprite_url(name)
    if path = sprite_path(name)
      "/assets%s" % path.sub(Rails.root.join('public/assets').to_s, '')
    else
      raise "Sprite '#{name}' is not compiled yet"
    end
  end

  def sprite_path(name)
    sprite_files.select{|f| f =~ /#{ name }-([^\/]+).png/ }.sort_by{|f| File.mtime(f) }.last
  end

  def sprite_files
    Compass::SpriteImporter.find_all_sprite_map_files(Compass.configuration.generated_images_path)
  end
end