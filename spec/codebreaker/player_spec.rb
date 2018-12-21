# frozen_string_literal: true

module Codebreaker
  RSpec.describe Player do
    let(:user_name) { 'Player_1' }
    let(:user) { Player.new(:user_name) }

    describe 'When #valid_name?' do
      it 'is true' do
        expect(user.valid_name?).to be true
      end

      it 'is false' do
        user.name = 'Pl'
        expect(user.valid_name?).to be false
      end
    end
  end
end
