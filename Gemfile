source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'

# Use sqlite3 as the database for Active Record
# gem 'sqlite3'

# PostgreSQL for Relational Database
gem 'pg'


gem 'sass-rails', '>= 3.2'
# Use SCSS for stylesheets
# gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem "passenger"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Using 'Stripe' to process payments
gem 'stripe'

# To find geographical location (lat/long)
gem 'geocoder'

# Google maps
gem 'gmaps4rails'


# AWS integration
# gem 'aws-sdk-rails'
# gem 'aws-sdk'

# Frontend framework
gem 'materialize-sass'

gem 'underscore-rails'

# Passing data from controllers to JS files
gem 'gon'

#Highstock for data visualisation
gem "highcharts-rails", ">=5.0.0"
gem "highstock-rails"

gem 'faker'

# For log inspection
gem 'rails_stdout_logging'

# Losant
gem 'losant_rest'
gem "http"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  # c3 for data visualisation, feeds off d3
  # gem 'c3-rails'

  # d3 for data visualisation
  # gem 'd3_rails'

end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'guard-livereload', '~> 2.5', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
end

