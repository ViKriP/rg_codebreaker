# frozen_string_literal: true

#module Codebreaker
#  class Constants
#    ROOTDIR = File.expand_path(__dir__)
#    STATS_DB = ROOTDIR + '/lib/db/stats.yml'
  #end
#end

require 'i18n'
require 'yaml'
require 'terminal-table'
require './lib/i18n_config'
require './lib/codebreaker/difficulty'
require './lib/codebreaker/validation'
require './lib/codebreaker/storage'
require './lib/codebreaker/player'
require './lib/codebreaker/game'
require './lib/codebreaker/console'
require './lib/codebreaker'
