require 'spec_helper'

module Codebreaker
  RSpec.describe Storage do
    before do
      stub_const('STATS_DB', '/lib/db/stats.yml')
      File.new('./lib/db/test_stats.yml', 'w+')
    end

    after { File.delete('./lib/db/test_stats.yml') }


    describe '#validate_name' do
      it 'generates secret code'
      it 'saves 4 numbers secret code'
      it 'saves secret code with numbers from 1 to 6'
    end
  end
end
