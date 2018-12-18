# frozen_string_literal: true

ROOTDIR = File.expand_path(__dir__)
STATS_DB = ROOTDIR + '/lib/db/stats.yml'

require 'i18n'
require 'yaml'
require 'terminal-table'
I18n.load_path << Dir[File.expand_path('./lib/locales') + '/*.yml']
I18n.default_locale = :en
require './lib/codebreaker/difficult'
require './lib/codebreaker/validation'
require './lib/codebreaker/storage'
require './lib/codebreaker/player'
require './lib/codebreaker/game'
require './lib/codebreaker/console'
require './lib/codebreaker'
