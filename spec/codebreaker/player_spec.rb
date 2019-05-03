# frozen_string_literal: true

require 'spec_helper'

module Codebreaker
  RSpec.describe Player do
    let(:user_name) { 'Player_1' }
    let(:user) { Player.new(:user_name) }

    describe '#valid_name?' do
      it 'When name is true' do
        expect(user.valid_name?).to be true
      end

      it 'When name is false' do
        user.name = 'Pl'
        expect(user.valid_name?).to be false
      end
    end
  end
end
