source 'https://rubygems.org'

ruby "2.5.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'bundler', '>= 1.8.4'
gem 'rails',   '~> 5.0.6'
gem 'pg'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.0.0'
gem 'coffee-rails', '4.2.1'
gem 'sprockets',    '~> 3.0'
gem 'jquery-rails', '4.1.1'
gem 'jquery-ui-rails'
gem 'turbolinks',   '5.0.1'
gem 'jquery-turbolinks'
gem 'jbuilder',     '2.4.1'
gem 'bootstrap-sass', '3.3.6'
gem 'bcrypt',         '3.1.11'
gem 'will_paginate',           '3.1.0'
gem 'bootstrap-will_paginate', '0.0.10'
gem 'simple_form'
gem 'select2-rails'
gem "font-awesome-rails"
gem 'date_validator',   '~> 0.9.0'
gem 'paperclip',        "~> 5.0.0"
gem 'paperclip-i18n', '4.3.0'
gem 'simple_calendar', '~> 2.2', '>= 2.2.5'
gem 'icalendar', '~> 2.4', '>= 2.4.1'
gem 'ransack', github: 'activerecord-hackery/ransack'
gem 'docx', '~> 0.2.07', require: ["docx"]
gem 'pg_search'
gem 'rails-assets-sweetalert2', '~> 5.1.1', source: 'http://insecure.rails-assets.org'
gem 'sweet-alert2-rails'
gem "pundit"
gem 'puma',         '3.11.0'
# gem "time_frame"
# gem "draper"
# gem "seedbank"
# gem "paper_trail"
# gem 'inherited_resources' not OK with rails 5 AFAIK 15/12/2017
# gem 'has_scope' # TODO ransck impact
# temp

group :development, :test do

  gem "factory_bot_rails",     "~> 4.0"
  gem 'as-duration'
  gem 'byebug',  '9.0.0', platform: :mri
  # gem "capistrano", "~> 3.8"
  # gem 'capistrano-rails', '~> 1.3'
  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
  gem "better_errors"
  gem "binding_of_caller"
  gem 'faker',          '1.8.6'
  gem 'color_pound_spec_reporter'
end

group :development do
  gem 'web-console',           '3.1.1'
  gem 'listen',                '3.0.8'
  gem 'spring',                '1.7.2'
  gem 'spring-watcher-listen', '2.0.0'
end

group :test do
  gem 'rails-controller-testing', '0.1.1'
  gem 'minitest-reporters',       '1.1.9'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
  gem 'simplecov', require: false
end

group :production do
  # gem "passenger", "5.1.12", require: "phusion_passenger/rack_handler"
end
