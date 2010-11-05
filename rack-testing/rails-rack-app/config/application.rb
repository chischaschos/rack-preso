require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module RailsRackApp
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib) 
    config.middleware.insert_before Rack::Runtime, "AverageRuntime"
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
  end
end
