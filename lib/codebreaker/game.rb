# frozen_string_literal: true

module Codebreaker
  class Game  
    include Validation  
    attr_accessor :secret_code, :attempts, :hints, :user_hints, :level_hints,
                  :difficulty, :attempt_result

    def initialize(difficulty, attempts, hints)
      @secret_code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
      @difficulty = difficulty
      @attempts = attempts
      @hints = hints
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
