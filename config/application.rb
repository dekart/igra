require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Igra
  class Application < Rails::Application
    config.autoload_paths += Dir[config.root.join('lib')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # Load locales from subfolders of 'config/locales'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Remove one of the default headers to allow application to be launched within IFRAME
    config.action_dispatch.default_headers.delete('X-Frame-Options')

    # Generate sprites to the folder where we can serve them from
    config.compass.generated_images_dir = "public/assets/sprites"
    config.compass.http_generated_images_path = "/assets/sprites"

    config.assets.paths << Rails.root.join("app/assets/sounds").to_s << Rails.root.join("vendor/assets/flash").to_s

    config.assets.initialize_on_precompile = true
  end
end
