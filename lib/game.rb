# frozen_string_literal: true

DIFFICULTIES = "\n\r\x1b[33mAvailable options\n\reasy | medium | hell\x1b[0m\n\r"
WRONG_COMMAND = "\x1b[1;31mYou entered the wrong command.\x1b[0m\n\r\x1b[31mSelect one of the listed commands.\x1b[0m"

module Game
#  include Validation
  include Logic
  attr_accessor :secret_code, :difficulty
#  class Console

  def generate_code
    @secret_code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
  end
=begin
  def easy
    generate_code
    puts "ВВедите код"
    @guess = gets.chomp
#Проверка @guess на корректность
    #puts @secret_code
puts "Your guess \x1b[36m#{@guess}\x1b[0m"
#Запустить логику на обработку @guess
#!!!!!!!!!!!!!!!!!!!!!!!!!!!
  end
=end
  def difficulty_choice
    puts DIFFICULTIES
    puts "Enter your choice."
    @difficulty = gets.chomp
    difficulties
  end

  def difficulties
    case @difficulty
      when 'easy' then level_game('easy')
      when 'medium' then level_game('medium')
      when 'hell' then level_game('hell')
      else puts WRONG_COMMAND
        difficulty_choice
    end
  end

#  end
end
