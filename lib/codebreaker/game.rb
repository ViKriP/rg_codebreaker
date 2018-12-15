# frozen_string_literal: true

module Codebreaker
  class Game
    include Validation
    attr_accessor :secret_code, :attempts, :hints, :user_hints, :level_hints,
                  :difficulty, :attempt_result, :attempts_total, :hints_total,
                  :tmp_secret_code, :guess_won, :guess_loss

    DIGIT_MIN_VALUE = 1
    DIGIT_MAX_VALUE = 6
    CODE_SIZE = 4
    DIGIT_PLACE = '+'
    DIGIT_PRESENCE = '-'                  

    def initialize(difficulty)
      @secret_code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
      @difficulty = difficulty[:name]
      @attempts = difficulty[:attempts]
      @attempts_total = difficulty[:attempts].clone
      @hints = difficulty[:hints]
      @hints_total = difficulty[:hints].clone
      @level_hints = []
      @tmp_secret_code = []
      @user_hints = @secret_code.clone.shuffle
    end

    def hint
      if @hints.positive?
        @level_hints.push(@user_hints[@hints-1])
        @hints -= 1
      end
    end

    def guess(num)
      print @secret_code
      @attempts -= 1 if @attempts.positive?
        
      @attempt_result = compare_attempt(num)
      @guess_won = true if @attempt_result == Array.new(CODE_SIZE, DIGIT_PLACE)
      @guess_loss = true if @attempts == 0
    end
    
    def save_result_game(player_name)
      result_game = { name: player_name, difficulty: @difficulty,
                     attempts_total: @attempts_total,
                     attempts_used: @attempts_total - @attempts,
                     hints_total: @hints_total, hints_used: @hints_total - @hints }
      Storage.new.save(result_game)
    end

    def guess_valid(num)
      validate_number(num: num, min_value: DIGIT_MIN_VALUE, max_value: DIGIT_MAX_VALUE, length: CODE_SIZE)
    end

    private

    def compare_attempt(num)
      @tmp_secret_code = @secret_code.clone
      num = num.each_char.map(&:to_i)
      chars_hints = []
      num_presence = []
      tmp_secret_code_presence = []

      num.each_with_index do |digit, index|
        if @tmp_secret_code.at(index) == digit
          chars_hints.push(DIGIT_PLACE)
        else
          num_presence.push(num.at(index))
          tmp_secret_code_presence.push(tmp_secret_code.at(index))
        end
      end

      num_presence.each_with_index do |digit, index|
        tmp_secret_code_presence.each_with_index do |digit2, index2|
          if digit == digit2
            chars_hints.push(DIGIT_PRESENCE)
            tmp_secret_code_presence[index2] = 0
          end
        end
      end
      chars_hints
    end
  end
end
