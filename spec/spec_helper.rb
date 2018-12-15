# frozen_string_literal: true

require 'yaml'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage 95
end

ROOTDIR = File.expand_path(__dir__)
STATS_DB = ROOTDIR + '/lib/db/stats.yml'
#puts File.expand_path('./lib/db/stats.yml')
#require File.expand_path('lib/db/stats.yml')
require 'i18n'
require 'bundler/setup'
require 'i18n_config'
require 'codebreaker/validation'
require 'codebreaker/storage'
require 'codebreaker/player'
require 'codebreaker/game'
require 'codebreaker/console'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  #config.before(:suite) do
  #  Codebreaker::Storage.check_path_existence
  #end
end
