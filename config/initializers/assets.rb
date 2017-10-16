# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

%w( farm_blocks water_tanks inflow_meters).each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.*", "#{controller}.css"]
end

Rails.application.config.assets.precompile += %w( welcome.js )
Rails.application.config.assets.precompile += %w( sessions.js )
Rails.application.config.assets.precompile += %w( alerts.js )
Rails.application.config.assets.precompile += %w( highcharts.css )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
