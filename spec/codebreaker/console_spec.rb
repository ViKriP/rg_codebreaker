# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    before do
      allow(subject).to receive(:loop).and_yield
    end

    describe '#start' do
      it 'prints welcome method' do
        allow(subject).to receive(:main_menu)
        expect { subject.start }.to output(I18n.t(:welcome) + "\n").to_stdout
      end
    end

    describe '#main_menu' do
      let(:console) { described_class.new }
      let(:game) { Game.new(Difficulty.find('easy').level) }

      it 'checks i18n key existence' do
        expect(I18n.exists?(:main_menu_print, :en)).to be true
        expect(I18n.exists?(:wrong_command, :en)).to be true
      end

      it 'when hint is selected' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], 'Player', 'easy', 'hint')
        subject.main_menu
      end

      it 'when introduced attempt' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], 'Player', 'easy', '1111')
        subject.main_menu
      end

      it 'when wrong difficulty is selected' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:start], 'Player', 'easyyyyy')
        subject.main_menu
      end

      it 'when the entered attempt won' do
        subject.instance_variable_set(:@game, game)
        game.instance_variable_set(:@guess_won, true)
        allow(subject).to receive_message_chain(:gets, :chomp).and_return('n', 'y')
        subject.instance_eval { win }
      end

      it 'when the entered attempt loss' do
        subject.instance_variable_set(:@game, game)
        game.instance_variable_set(:@guess_loss, true)
        allow(subject).to receive_message_chain(:gets, :chomp).and_return('y')
        subject.instance_eval { loss }
      end

      it 'receives #stats for same command' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:stats], 'wrong_command')
        subject.main_menu
      end

      it 'receives #rules for same command' do
        allow(subject).to receive_message_chain(:gets, :chomp).and_return(Console::COMMANDS[:rules], 'wrong_command')
        subject.main_menu
      end

      it 'receives #check_command if user types something else' do
        allow(subject).to receive(:puts).with(I18n.t(:main_menu_print))
        allow(subject).to receive(:puts).with(I18n.t(:wrong_command))
        allow(subject).to receive(:gets).and_return('something')
        expect(subject.main_menu).to eq(nil)
      end
    end
  end
end
