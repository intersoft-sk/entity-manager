source 'http://rubygems.org'

#gem 'rails', '3.1.0'
gem 'rails', '3.1.12'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


gem 'therubyracer', require: "v8"
gem 'metric_fu'
gem 'kaminari'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'


#gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'
gem 'omniauth-linkedin'

gem 'factory_girl_rails'

gem 'pg'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'cucumber-rails', :require => false
  gem 'minitest' #added based on error message after first run of cucumber
  gem 'faker'
end

group :test, :development do  
  gem 'cucumber-rails-training-wheels' # some pre-fabbed step definitions  
  gem 'database_cleaner' # to clear Cucumber's test database between runs
  gem 'capybara'         # lets Cucumber pretend to be a web browser
  gem 'launchy'          # a useful debugging aid for user stories
  gem 'rspec-rails'
#  gem 'ZenTest'
#  gem 'sqlite3' # use SQLite only in development and testing
#  gem 'ruby-debug19' # use Ruby debugger
#  gem 'linecache19'     #'linecache19', :git => 'git://github.com/mark-moseley/linecache'
#  gem 'ruby-debug-base19x', '~> 0.11.30.pre4'
#  gem 'ruby-debug19'
#  gem 'simplecov', :require => false
end

# use Haml for templates
gem 'haml'

group :production do
  gem 'newrelic_rpm'
end

gem 'Saikuro'
