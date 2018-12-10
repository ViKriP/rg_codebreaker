# frozen_string_literal: true

module Codebreaker
  class Game  
    include Validation  
    attr_accessor :secret_code, :attempts, :hints, :user_hints, :level_hints,
                  :difficulty, :attempt_result, :attempts_total, :hints_total

    def initialize(difficulty)
      @secret_code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
      @difficulty = difficulty[:name]
      @attempts = difficulty[:attempts]
      @attempts_total = difficulty[:attempts].clone
      @hints = difficulty[:hints]
      @hints_total = difficulty[:hints].clone
      @level_hints = []
      @user_hints = @secret_code.clone.shuffle
    end

    def hint
      if @hints > 0
        @level_hints.push(@user_hints[@hints-1])
        @hints -= 1
      end
    end
  
    def guess(num)
      #return unles guess_valid(num)
      print @secret_code
      @attempts -= 1 if @attempts > 0
        
      @attempt_result = compare_attempt(num)
    end
    
    def save_result_game(player_name)
      result_game = {name: player_name, difficulty: @difficulty,
                     attempts_total: @attempts_total,
                     attempts_used: @attempts_total - @attempts,
                     hints_total: @hints_total, hints_used: @hints_total - @hints}
      Storage.new.save(result_game)
    end

    def guess_valid(num)
      validate_number(num: num, min_value: 1, max_value: 6, length: 4)
    end

    private

    def compare_attempt(num)
      @tmp_secret_code = @secret_code.clone
      num = num.each_char.map(&:to_i)
      chars_hints = []
      num.each_with_index { |digit, index| chars_hints.push(compare_secret_code(digit, index)) }
      chars_hints.compact.sort
    end
  
    def compare_secret_code(digit, index)
      if @tmp_secret_code.at(index) == digit
        char_hint = '+'
        @tmp_secret_code[index] = nil
      else
        @tmp_secret_code.each_with_index do |digit2, index2|
          if digit2 == digit
            char_hint = '-'
            @tmp_secret_code[index2] = nil
          end
        end
      end
      char_hint
    end
  end
end
