# frozen_string_literal: true

require 'yaml'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end

require 'bundler/setup'
require '././autoloader.rb'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true
