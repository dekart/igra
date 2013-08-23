Rails.application.assets.register_postprocessor('application/javascript', AssetPathPreprocessor)

# Compile stylesheets first, then images, then javascripts
Rails.configuration.assets.paths = Rails.configuration.assets.paths.map{|p|
  [
    p.to_s.include?('/stylesheets') ? 1 : (p.to_s.include?('/images') ? 2 : 3),
    p
  ]
}.sort_by(&:first).map(&:last)