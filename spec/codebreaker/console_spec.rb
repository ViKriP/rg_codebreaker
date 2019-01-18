# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    let(:current_subject) { described_class.new }
    let(:player) { instance_double('Player', name: 'Player') }
    let(:game) { instance_double('Game', hints: 0, level_hints: 0, attempts: 15, secret_code: [1, 1, 1, 1]) }
    let(:storage) { instance_double('Storage') }
    let(:valid_name) { 'Player' }
    let(:invalid_name) { 'Pl' }
    let(:difficulty_name) { 'easy' }

    before do
      allow(subject).to receive(:loop).and_yield
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

      it 'receives #rules for same command' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:rules], Console::COMMANDS[:start])
        expect { subject.start }.to output(/#{Regexp.quote(I18n.t(:rules))}/).to_stdout
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
    end

    describe 'when hint is ended' do
      before do
        allow(current_subject).to receive(:loop).and_yield
      end

      it do
        current_subject.instance_variable_set(:@game, game)
        current_subject.instance_variable_set(:@player, player)

        allow(current_subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:hint])

        expect { current_subject.send(:game_state) }.to output(/#{Regexp.quote(I18n.t(:ended_hints))}/).to_stdout
      end
    end

    describe 'game result' do
      it 'When guess is won' do
        subject.instance_variable_set(:@game, game)
        current_subject.instance_variable_set(:@player, player)

        allow(subject).to receive_message_chain(:gets, :chomp).and_return('n', 'y')
        expect { subject.send(:win) }.to output(/#{Regexp.quote(I18n.t(:win))}/).to_stdout
      end

      it 'When guess is loss' do
        subject.instance_variable_set(:@game, game)
        current_subject.instance_variable_set(:@player, player)

        allow(subject).to receive_message_chain(:gets, :chomp).and_return('y')
        expect { subject.send(:loss) }.to output(/#{Regexp.quote(I18n.t(:loss))}/).to_stdout
      end
    end
  end
end
