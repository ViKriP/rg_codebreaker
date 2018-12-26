# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    let(:game) { Game.new(Difficulty.find('easy').level) }
    let(:player) { Player.new('Player') }
    let(:valid_name) { 'Player' }
    let(:invalid_name) { 'Pl' }
    let(:difficulty_name) { 'easy' }
    let(:result_game) {
      { name: 'Player',
        difficulty: 'easy',
        attempts_total: 15,
        attempts_used: 1,
        hints_total: 2,
        hints_used: 1 }
    }.freeze

    before do
      allow(subject).to receive(:loop).and_yield
      stub_const('Codebreaker::Storage::STATS_DB', './lib/db/test__stats.yml')
      Storage.new.save(result_game)
    end

    after do
      File.delete('./lib/db/test__stats.yml')
    end

    describe '#start' do
      it 'prints welcome method' do
        allow(subject).to receive(:gets)
        allow(subject).to receive(:main_menu)
        expect { subject.start }.to output(/Welcome/).to_stdout
      end
    end

    describe '#main_menu' do
      it 'receives #start for same command' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], Console::COMMANDS[:start])
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:what_name))}/).to_stdout
      end

      it 'when the database does not exist for #stats' do
        stub_const('Codebreaker::Storage::STATS_DB', './lib/db/wrong_db.yml')
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:stats], Console::COMMANDS[:start])
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:db_empty))}/).to_stdout
      end

      it 'when the database exist for #stats' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:stats], Console::COMMANDS[:start])
        expect { subject.start }.to output(/Rating/).to_stdout
      end

      it 'receives #rules for same command' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:rules], Console::COMMANDS[:start])
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:rules))}/).to_stdout
      end

      it 'receives #exit for same command' do
        allow(subject).to receive(:gets).and_return(Console::COMMANDS[:exit])
        allow(subject).to receive(:puts)
        allow(subject).to receive(:exit)
        expect(subject.start).to eq(nil)
      end
    end

    describe '#registration' do
      it 'When name is correct' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], valid_name)
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:difficulties_menu))}/).to_stdout
      end

      it 'When name is wrong' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], invalid_name)
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:wrong_name))}/).to_stdout
      end
    end

    describe '#choose_difficulty' do
      it 'When choose difficulty is correct' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], valid_name, difficulty_name)
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:game_menu))}/).to_stdout
      end

      it 'When choose difficulty is wrong' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], valid_name, '_wrong')
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:wrong_command))}/).to_stdout
      end
    end

    describe '#game_state' do
      it 'When guess is correct' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], valid_name, difficulty_name, '1111')
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:game_menu))}/).to_stdout
      end

      it 'When guess is wrong' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], valid_name, difficulty_name, '11')
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:wrong_command))}/).to_stdout
      end

      it 'when hint is selected' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], valid_name, difficulty_name, Console::COMMANDS[:hint])
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:player_used, attempts: 15, hints: 2))}/).to_stdout
      end

      it 'when hint is ended' do
        subject.instance_variable_set(:@game, game)
        subject.game.instance_variable_set(:@hints, 0)

        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], valid_name, difficulty_name, Console::COMMANDS[:hint])
        expect(subject.game.hints).to eq(0)
      end
    end

    describe '#winning_state' do
      it 'When guess is won' do
        subject.instance_variable_set(:@game, game)
        subject.instance_variable_set(:@player, player)

        game_own = subject.instance_variable_get(:@game)
        subject.game.guess(game_own.instance_variable_get(:@secret_code).join)

        allow(subject).to receive_message_chain(:gets, :chomp).and_return('y', 'y')
        expect { subject.send(:win) }.to output(/#{Regexp.quote(I18n.t(:win))}/).to_stdout
      end

      it 'When guess is loss' do
        subject.instance_variable_set(:@game, game)

        game_own = subject.instance_variable_get(:@game)
        game_own.instance_variable_set(:@attempts, 1)

        subject.game.guess('6666')

        allow(subject).to receive_message_chain(:gets, :chomp).and_return('y')
        expect { subject.send(:loss) }.to output(/#{Regexp.quote(I18n.t(:loss))}/).to_stdout
      end
    end
  end
end
