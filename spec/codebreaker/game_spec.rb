# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    subject(:game) { described_class.new(Difficulty.find('easy').level) }

    before do
      stub_const('Codebreaker::Storage::STATS_DB', './lib/db/test-stats.yml')
    end

    describe '#hint' do
      it 'When hints are over' do
        game.instance_variable_set(:@hints, 0)
        expect(game.hints).to eq(0)
      end

      it 'When hints are not over' do
        game.instance_variable_set(:@hints, 1)
        expect(game.hints).to eq(1)
      end

      it 'When hints decrease' do
        game.instance_variable_set(:@hints, 2)
        game.hint
        expect(game.hints).to eq(1)
      end
    end

    describe '#guess' do
      it 'When guess are over' do
        game.instance_variable_set(:@attempts, 0)
        expect(game.attempts).to eq(0)
      end

      it 'When guess are not over' do
        game.instance_variable_set(:@attempts, 1)
        expect(game.attempts).to eq(1)
      end

      it 'When guess decrease' do
        game.instance_variable_set(:@attempts, 2)
        game.guess('1111')
        expect(game.attempts).to eq(1)
      end

      it 'When guess won' do
        game.instance_variable_set(:@secret_code, [1, 1, 1, 1])
        game.guess('1111')
        expect(game.guess_won).to eq(true)
      end

      it 'When guess loss' do
        game.instance_variable_set(:@secret_code, [1, 1, 1, 1])
        game.instance_variable_set(:@attempts, 1)
        game.guess('1112')
        expect(game.guess_loss).to eq(true)
      end

      context 'when the attempt is correct' do
        [['6543', '5643', '++--'],
         ['6543', '6411', '+-'],
         ['6543', '6544', '+++'],
         ['6543', '3456', '----'],
         ['6543', '6666', '+'],
         ['6543', '2666', '-'],
         ['6543', '2222', ''],
         ['6666', '1661', '++'],
         ['1234', '3124', '+---'],
         ['1234', '1524', '++-'],
         ['1234', '1234', '++++']].each do |item|
          it "if secret_code is #{item[0]} and user input is #{item[1]} then answer is #{item[2]}" do
            game.instance_variable_set(:@secret_code, item[0].each_char.map(&:to_i))
            game.guess(item[1])
            expect(game.attempt_result.join).to eq(item[2])
          end
        end
      end
    end

    describe '#guess_valid()' do
      it 'When guess is valid' do
        expect(game.guess_valid?('1111')).not_to eq(false)
        expect(game.guess_valid?('1111')).not_to eq(nil)
      end
    end

    describe '#save_result_game' do
      let(:storage) { Storage.new }

      it 'When saving result' do
        game.save_result_game('Player')
        res = storage.load[0]
        expect(res[:name]).to eq('Player')
      end
    end
  end
end
