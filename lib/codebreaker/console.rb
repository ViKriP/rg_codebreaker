# frozen_string_literal: true

DIFFICULTIES = "\n\r\x1b[33mAvailable options\n\reasy | medium | hell\x1b[0m\n\rEnter your choice."
WRONG_COMMAND = "\x1b[1;31mYou entered the wrong command.\x1b[0m\n\r\x1b[31mSelect one of the listed commands.\x1b[0m"

HI = ''
OPTIONS = "\n\r\x1b[33mAvailable options\n\rstart | rules | stats | exit\x1b[0m\n\rEnter your choice."
GAME_OPTIONS = "\n\r\x1b[1;33mEnter your guess or\x1b[0m\n\r\x1b[33mAvailable options\n\rhint | exit\x1b[0m\n\r"

STATS = "Den 5 jjjdkfl 676 dfd"

WIN = "\n\rYou won!!!"
LOSS = "You lose."

module Codebreaker
  class Console
    #include Validation
    attr_accessor :tmp_secret_code, :player, :game

def initialize
  #@option = ''
end
=begin
def difficulty_choice
  puts DIFFICULTIES
  #puts "Enter your choice."
  #@difficulty = gets.chomp
  #Game.new(gets.chomp)
  difficulties(gets.chomp)
end
=end
def difficulties
  puts DIFFICULTIES
  case gets.chomp
    when 'easy' then @game = Game.new('easy', 3, 2)
      options_game  #Game.level_game('easy')
    when 'medium' then Game.level_game('medium')
    when 'hell' then Game.level_game('hell')
    else puts WRONG_COMMAND
      #difficulty_choice
      difficulties
  end
end

def options_game    
  puts GAME_OPTIONS    
  puts "You have attempts - #{@game.attempts} and hints - #{@game.hints}"    
  puts "\x1b[32mYour hints - #{@game.level_hints}\x1b[0m" if @game.level_hints.size > 0    
  #@option_game = gets.chomp    
  @game.choice_game(gets.chomp)

  puts "\n\r\x1b[31mYou do not have hints\x1b[0m" if @game.hints <= 0

  if @game.attempts <= 0 
    puts("\n\rYou do not have attempts")
    puts LOSS
    puts "Correct secret code - #{@game.secret_code.join}\n\r"
    #difficulty_choice
    difficulties
  end
  
  puts @game.attempt_result

  win if @game.attempt_result == Array.new(4, '+')

  options_game
end

def start
  puts I18n.t(:hi)
  #puts "\n\r\x1b[1mWelcome to the game Codebreaker!!!\x1b[0m"
  #option_choice
  options

  #STDOUT.flush
end
=begin
def option_choice
  puts OPTIONS
  #puts "Enter your choice."
  @option = gets.chomp
  options
end
=end
def options
  puts OPTIONS
  case gets.chomp
    when 'start' then registration
    when 'rules' then rules
    when 'stats' then stats
    when 'exit' then exit
    else puts WRONG_COMMAND
      #option_choice
      options
  end
end

def registration
  puts "What is your name?"  
  @player = Player.new(gets.chomp)
  
  puts "Your name \x1b[36m#{@player.name}\x1b[0m"
  @player.valid_name? ? difficulties : puts("\x1b[31mName not valid\x1b[0m")
  
  registration
end

def rules
  puts RULES
  #option_choice
  options
end

def stats
  puts STATS
  #option_choice
  options
end

def win
  puts WIN
  exit
end

def exit
   abort "Goodbye!"
end
 


  end
end
