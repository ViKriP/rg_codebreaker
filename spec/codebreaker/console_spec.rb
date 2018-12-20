# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    before do
      allow(subject).to receive(:loop).and_yield
    end

    describe '#start' do
      it 'prints welcome method' do
        #allow(console).to receive(:main_menu)
        #expect(I18n.exists?(:welcome, :en)).to be true
        #expect(I18n.t(:welcome)).to be_nil
        #expect(I18n.t(:welcome)).to eq("\n\r\x1b[1mWelcome to the game Codebreaker!!!\x1b[0m")
       
        allow(subject).to receive(:main_menu)
        expect { subject.start }.to output(I18n.t(:welcome)+"\n").to_stdout
      end
    end

    describe '#main_menu' do
      it 'checks i18n key existence' do
        expect(I18n.exists?(:main_menu_print, :en)).to be true
        expect(I18n.exists?(:wrong_command, :en)).to be true
      end

      it 'receives #start for same command' do
        allow(subject).to receive(:puts).with(I18n.t(:main_menu_print))
        allow(subject).to receive_messages(:registration => :registration)
        allow(subject).to receive(:gets).and_return(Console::COMMANDS[:start])
        expect(subject.main_menu).to eq(:registration)
      end

      it 'receives #stats for same command' do
        allow(subject).to receive(:puts).with(I18n.t(:main_menu_print))
        allow(subject).to receive_messages(:stats => :stats)
        allow(subject).to receive(:gets).and_return(Console::COMMANDS[:stats])
        expect(subject.main_menu).to eq(:stats)
      end

      it 'receives #rules for same command' do
        allow(subject).to receive(:puts).with(I18n.t(:main_menu_print))
        allow(subject).to receive_messages(:rules => :rules)
        allow(subject).to receive(:gets).and_return(Console::COMMANDS[:rules])
        expect(subject.main_menu).to eq(:rules)
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
