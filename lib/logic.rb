# frozen_string_literal: true

GAME_OPTIONS = "\n\r\x1b[1;33mEnter your guess or\x1b[0m\n\r\x1b[33mAvailable options\n\rhint | exit\x1b[0m\n\r"
WRONG_COMMAND = "\x1b[1;31mYou entered the wrong command.\x1b[0m\n\r\x1b[31mSelect one of the listed commands.\x1b[0m"
WIN = "\n\rYou won!!!"
LOSS = "\n\rYou lose."

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
#puts "---- #{@level_hints}"
      @hints -= 1
    else
      puts "\x1b[31mYou do not have hints\x1b[0m"
    end
    options_game
  end

  def guess(num)
      print @secret_code
#      puts "\x1b[32mYour hints - #{@level_hints}\x1b[0m"
      @attempts -= 1 if @attempts > 0
     
      puts("\n\rYou do not have attempts")
      puts LOSS
      difficulty_choice if @attempts <= 0

#    @attempts > 0 ? @attempts -= 1 : puts("You do not have attempts")
    puts("#{num}")
    options_game
  end
  
  def level_game(level)
    generate_code
    @level_hints = []
#puts @secret_code.shuffle[0..1]
    @user_hints = @secret_code.shuffle
#puts @user_hints.shuffle[0..1]
    case level
      when 'easy' then @attempts = 2#15
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

  def compare_attempt
    
  end
end
