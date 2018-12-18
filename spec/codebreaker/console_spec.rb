# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Console do    
    let(:console) { described_class.new }

    describe '#start' do
      it 'prints welcome method' do
        allow(console).to receive(:main_menu)
        expect(I18n.exists?(:welcome, :en)).to be true
        #expect(I18n.t(:welcome)).to be_nil
        #expect(I18n.t(:welcome)).to eq("\n\r\x1b[1mWelcome to the game Codebreaker!!!\x1b[0m")
       
        #allow(console).to receive(:main_menu)
        #expect { console.start }.to output(I18n.t(:welcome)+"\n"+I18n.t(:bye)+"\n").to_stdout
      end
    end

    describe '#main_menu' do
    before do
      allow(console).to receive(:loop).and_yield
    end

    it 'receives #start for same command' do
      allow(console).to receive(:gets).and_return(Console::COMMANDS[:start])
      allow(console).to receive(:registration)
      expect(console.main_menu).to eq(nil)
    end

    it 'receives Storage#stats for same command' do
      allow(console).to receive(:gets).and_return(Console::COMMANDS[:stats])
      allow(console).to receive(:stats)
      expect(console.main_menu).to eq(nil)
    end

    it 'receives #rules for same command' do
      allow(console).to receive(:gets).and_return(Console::COMMANDS[:rules])
      allow(console).to receive(:puts)
      allow(console).to receive(:rules)
      expect(console.main_menu).to eq(nil)
    end

    it 'receives #check_command if user types something else' do
      expect(I18n.exists?(:wrong_command, :en)).to be true
    end
end
=begin
    describe '#main_menu' do
      #after { current_subject.main_menu }

      it 'prints main_menu method' do
        expect(I18n.exists?(:main_menu, :en)).to be true
      end

      context 'when registration' do
        it do
          #allow(current_subject).to receive(:registration)
          allow(current_subject).to receive(:user_input).and_return(Console::COMMANDS[:start])
          expect(current_subject).to receive(:registration)
        end
      end

  end
=end 
 
 

  end
end
