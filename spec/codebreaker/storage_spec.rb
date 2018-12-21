# frozen_string_literal: true

module Codebreaker
  RSpec.describe Storage do
    let(:base) { described_class.new }

    before do
      stub_const('Codebreaker::Storage::STATS_DB', './lib/db/test_stats.yml')
      File.delete(Codebreaker::Storage::STATS_DB)
    end

    after do
      File.delete(Codebreaker::Storage::STATS_DB)
    end

    describe '#save' do
      it 'When savig' do
        result_game = { name: 'Player', difficulty: 'easy',
                        attempts_total: 15,
                        attempts_used: 2,
                        hints_total: 2,
                        hints_used: 1 }
        base.save(result_game)
        res = base.load[0]
        expect(res[:name]).to eq('Player')
      end
    end

    xdescribe '#load_stats_table' do
      #let(:Terminal) { Terminal::Table.new }

      it 'When loading stats table' do
        #allow(base).to receive(:Terminal)
        result_game = { name: 'Player', difficulty: 'easy',
                      attempts_total: 15,
                      attempts_used: 2,
                      hints_total: 2,
                      hints_used: 1 }
        base.save(result_game)        
        #expect(base.load_stats_table).to eq('111')
      end
    end
  end
end