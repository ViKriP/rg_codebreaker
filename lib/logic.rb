# frozen_string_literal: true

GAME_OPTIONS = "\n\r\x1b[1;33mEnter your guess or\x1b[0m\n\r\x1b[33mAvailable options\n\rhint | exit\x1b[0m\n\r"
WRONG_COMMAND = "\x1b[1;31mYou entered the wrong command.\x1b[0m\n\r\x1b[31mSelect one of the listed commands.\x1b[0m"
WIN = "\n\rYou won!!!"
LOSS = "You lose."

module Logic
  include Validation
  attr_accessor :option_game, :attempts, :hints, :user_hints, :level_hints

  def options_game
    puts GAME_OPTIONS
    puts "You have attempts - #{@attempts} and hints - #{@hints}"
    puts "\x1b[32mYour hints - #{@level_hints}\x1b[0m" if @level_hints.size > 0
    @option_game = gets.chomp
    choice_game
  end

  def choice_game
    case @option_game
      when 'hint' then hint
      when 'exit' then exit
      else guess_valid(@option_game) ? guess(@option_game) : 
           puts(WRONG_COMMAND)
           options_game
    end
  end

  def hint
    if @hints > 0
      @level_hints.push(@user_hints[@hints-1])
      @hints -= 1
    else
      puts "\n\r\x1b[31mYou do not have hints\x1b[0m"
    end
    options_game
  end

  def guess(num)
    print @secret_code
    @attempts -= 1 if @attempts > 0
     
    if @attempts <= 0 
      puts("\n\rYou do not have attempts")
      puts LOSS
      puts "Correct secret code - #{@secret_code.join}\n\r"
      difficulty_choice
    end
      
    #puts "#{Array.new(4, '+')} *** #{compare_attempt(num)}"
    #qqq = Array.new(4, '+')

    #win if compare_attempt(num) == Array.new(4, '+')
      
    puts compare_attempt(num)
    options_game
  end

  def win
    puts WIN
    exit
  end
  
  def level_game(level)
    generate_code
    @level_hints = []
#puts @secret_code.shuffle[0..1]
    @user_hints = @secret_code.shuffle
#puts @user_hints.shuffle[0..1]
    case level
      when 'easy' then @attempts = 3#15
        @hints = 2
      when 'medium' then @attempts = 10
        @hints = 1
      when 'hell' then @attempts = 5
        @hints = 1
    end
    options_game
  end

  private

  def guess_valid(num)
    validate_number(num: num, min_value: 1, max_value: 6, length: 4)
  end

  def compare_attempt(num)
    @tmp_secret_code = @secret_code.clone
    num = num.each_char.map(&:to_i)
    code_help = []
    num.each_with_index { |digit, index| code_help.push(compare_secret_code(digit, index)) }
    code_help.compact.sort
  end

  def compare_secret_code(digit, index)
    if @tmp_secret_code.at(index) == digit
      arrh = '+'
      @tmp_secret_code[index] = nil
    else
      @tmp_secret_code.each_with_index do |digit2, index2|
        if digit2 == digit
          arrh = '-'
          @tmp_secret_code[index2] = nil
        end
      end
    end
    arrh
  end
end