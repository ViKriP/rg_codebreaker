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

#require './autoloader.rb'

require 'i18n'
#require './lib/i18n_config'
#require 'bundler/setup'
#require './lib/codebreaker/validation'
#require './lib/codebreaker/storage'
#require './lib/codebreaker/player'
#require './lib/codebreaker/game'
require './lib/codebreaker/console'

I18n.load_path << Dir[File.expand_path('lib/locales') + '/*.yml']
I18n.default_locale = :en

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

=begin
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
=end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end