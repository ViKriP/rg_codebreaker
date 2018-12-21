# frozen_string_literal: true

require 'yaml'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end

#ROOTDIR = File.expand_path(__dir__)
#STATS_DB = ROOTDIR + '/lib/db/stats.yml'

#puts File.expand_path('./lib/db/stats.yml')
#require File.expand_path('lib/db/stats.yml')
#require 'i18n_config'

require 'i18n'
#require 'bundler/setup'
require './lib/codebreaker'
require './lib/codebreaker/validation'
require './lib/codebreaker/storage'
require './lib/codebreaker/player'
require './lib/codebreaker/game'
require './lib/codebreaker/difficulty'
require './lib/codebreaker/console'
require './lib/i18n_config'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
end
end