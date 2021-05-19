source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# gem 'rails', github: "rails/rails"
gem 'rails', '~> 6.0.0.rc1'


####
# Note Bootstrap is managed by yarn 
# yarn add boostrap jquery popper.js


####


# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Use development version of Webpacker
gem 'webpacker', github: "rails/webpacker"

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

#### IdeaCrew-specific Gems
gem 'fast_jsonapi',             '~> 1.5'
gem 'mongoid',                  '~> 7.0'
gem 'globalid',                 '~> 0.4'
gem 'pundit',                   '~> 2.0'
gem 'dry-validation',           '~> 0.13'
gem 'dry-monads',               '~> 1.2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
####

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

#### IdeaCrew-specific Gems
  gem 'rspec-rails',            '~> 3.8'
  gem 'factory_bot_rails',      '~> 4'
  gem 'shoulda-matchers',       '~> 3'
  gem 'mongoid-rspec',          '~> 4'
  gem 'pry-byebug'
  gem 'database_cleaner',       '~> 1.7'
####

end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', github: 'rails/web-console'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'


#### IdeaCrew-specific Gems
  # Use Capistrano for deployment
  gem 'capistrano-rails',       '~>1.1.6'
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
####

end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
