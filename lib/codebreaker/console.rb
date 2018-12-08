# frozen_string_literal: true

DIFFICULTIES = "\n\r\x1b[33mAvailable options\n\reasy | medium | hell\x1b[0m\n\r"
WRONG_COMMAND = "\x1b[1;31mYou entered the wrong command.\x1b[0m\n\r\x1b[31mSelect one of the listed commands.\x1b[0m"

HI = ''
OPTIONS = "\n\r\x1b[33mAvailable options\n\rstart | rules | stats | exit\x1b[0m\n\r"

STATS = "Den 5 jjjdkfl 676 dfd"

module Codebreaker
  class Console
    include Validation
    attr_accessor :secret_code, :difficulty, :tmp_secret_code, :option, :name

def initialize
  @option = ''
end


def generate_code
  @secret_code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
end

def difficulty_choice
  puts DIFFICULTIES
  puts "Enter your choice."
  @difficulty = gets.chomp
  difficulties
end

def difficulties
  case @difficulty
    when 'easy' then Logic.new.level_game('easy')
    when 'medium' then level_game('medium')
    when 'hell' then level_game('hell')
    else puts WRONG_COMMAND
      difficulty_choice
  end
end


def start
  puts I18n.t(:hi)
  #puts "\n\r\x1b[1mWelcome to the game Codebreaker!!!\x1b[0m"
  option_choice

#STDOUT.flush
end

def option_choice
  puts OPTIONS
  puts "Enter your choice."
  @option = gets.chomp
  options
end

def registration
  puts "What is your name?"
  @name = gets.chomp
puts "Your name \x1b[36m#{name}\x1b[0m"
#puts validate_name(@name, 3, 20)
  #difficulty_choice if validate_name(@name, 3, 20)
validate_name(@name, 3, 20) ? difficulty_choice : puts("\x1b[31mName not valid\x1b[0m")
registration
end

def rules
  puts RULES
  option_choice
end

def stats
  puts STATS
  option_choice
end

def exit
   abort "Goodbye!"
end

private
  
def options
  case @option
    when 'start' then registration
    when 'rules' then rules
    when 'stats' then stats
    when 'exit' then exit
    else puts WRONG_COMMAND
      option_choice
  end
end

  end
end
