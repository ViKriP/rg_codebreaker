# frozen_string_literal: true

ROOTDIR = File.expand_path(__dir__)
STATS_DB = ROOTDIR + '/lib/db/stats.yml'

require 'i18n'
require 'yaml'
require 'terminal-table'
#require ROOTDIR + '/lib/codebreaker/locale_config'
require ROOTDIR + '/lib/codebreaker/difficult'
require ROOTDIR + '/lib/codebreaker/validation'
require ROOTDIR + '/lib/codebreaker/storage'
require ROOTDIR + '/lib/codebreaker/player'
require ROOTDIR + '/lib/codebreaker/game'
require ROOTDIR + '/lib/codebreaker/console'
require ROOTDIR + '/lib/codebreaker'
I18n.load_path << Dir[File.expand_path('lib/locales') + '/*.yml']
I18n.default_locale = :en
