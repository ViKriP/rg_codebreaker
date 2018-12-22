# frozen_string_literal: true

require 'yaml'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end

require 'i18n'
require 'bundler/setup'
require 'terminal-table'
require './lib/codebreaker'
require './lib/codebreaker/validation'
require './lib/codebreaker/storage'
require './lib/codebreaker/player'
require './lib/codebreaker/game'
require './lib/codebreaker/difficulty'
require './lib/codebreaker/console'
require './lib/i18n_config'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
