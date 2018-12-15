# frozen_string_literal: true

require 'i18n'
require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    before do
      I18n.available_locales = %i[en]
      #I18n.enforce_available_locales = false
    end

    describe '#start' do
      it 'prints welcome method' do
        allow(subject).to receive(:gets)
        allow(subject).to receive(:options)
        expect { subject.start }.to output(I18n.t(:welcome)+"\n").to_stdout
      end
    end

    describe '#options' do
      before do
        #allow(subject).to receive(:loop).and_yield
      end

      it 'receives #registration for same command' do
        allow(subject).to receive(:gets).and_return(I18n.t(:command_start))
        allow(subject).to receive(:start)
        expect(subject.options).to eq(nil)
      end

      it 'receives Storage#stats for same command' do
        allow(subject).to receive(:gets).and_return(I18n.t(:command_stats))
        allow(Storage).to receive(:stats)
        expect(subject.options).to eq(nil)
      end

      it 'receives #rules for same command' do
        allow(subject).to receive(:gets).and_return(I18n.t(:command_rules))
        allow(subject).to receive(:puts)
        allow(subject).to receive(:rules)
        expect(subject.options).to eq(nil)
      end

      it 'receives #exit for same command' do
        allow(subject).to receive(:gets).and_return(I18n.t(:command_exit))
        allow(subject).to receive(:puts)
        allow(subject).to receive(:exit)
        expect(subject.options).to eq(nil)
      end
=begin
      it 'receives #check_command if user types something else' do
        allow(subject).to receive(:gets).and_return('something')
        expect { subject.start_phase }.to output(/Unexpected/).to_stdout
      end

            it 'prints options' do
        allow(subject).to receive(:gets)
        allow(subject).to receive(:options)
        expect { subject.options }.to output(I18n.t(:options)+"\n").to_stdout
      end
=end
    end

  end
end
