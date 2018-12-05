# frozen_string_literal: true

ROOTDIR = File.expand_path(__dir__)
STATS_DB = ROOTDIR + '/lib/db/stats.yaml'

require 'yaml'
require ROOTDIR + '/lib/rules'
require ROOTDIR + '/lib/validation'
require ROOTDIR + '/lib/logic'
require ROOTDIR + '/lib/game'
require ROOTDIR + '/lib/codebreaker'
