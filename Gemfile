source 'https://rubygems.org'

gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'mongoid'
gem 'devise'

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'capistrano-rails', group: :development
  gem 'capistrano3-unicorn'
  gem 'capistrano-rvm'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end
