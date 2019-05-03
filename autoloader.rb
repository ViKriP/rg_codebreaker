# frozen_string_literal: true

ROOTDIR = File.expand_path(__dir__)

require 'i18n'
require 'yaml'
require 'terminal-table'
require ROOTDIR + '/lib/i18n_config'
require ROOTDIR + '/lib/codebreaker/version'
require ROOTDIR + '/lib/codebreaker/difficulty'
require ROOTDIR + '/lib/codebreaker/validation'
require ROOTDIR + '/lib/codebreaker/storage'
require ROOTDIR + '/lib/codebreaker/player'
require ROOTDIR + '/lib/codebreaker/game'
require ROOTDIR + '/lib/codebreaker/console'
