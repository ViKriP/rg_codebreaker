# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'i18n'

group :development do
  gem 'fasterer'
  gem 'rubocop'
  gem 'terminal-table'
end

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
end

group :development, :test do
  gem 'pry'
end
