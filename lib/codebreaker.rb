# frozen_string_literal: true

HI = ''
OPTIONS = "\n\r\x1b[33mAvailable options\n\rstart | rules | stats | exit\x1b[0m\n\r"

STATS = "Den 5 jjjdkfl 676 dfd"

class Codebreaker
  include Validation
  include Game
  attr_accessor :option, :name

  def initialize
    @option = ''
  end

  def start
    puts "\n\r\x1b[1mWelcome to the game Codebreaker!!!\x1b[0m"
    option_choice

#STDOUT.flush

#    puts "Your number \x1b[36m#{aa}\x1b[0m"

=begin 
    puts "Your number #{aa} \x1b[35mTest\x1b[0m 
\x1b[1;31mСтрока\x1b[0m с
\x1b[4;35;42mразными\x1b[0m \x1b[34;45mстилями\x1b[0m
\x1b[1;33mоформления\x1b[0m" 

puts "What is your name?"
STDOUT.flush
chompname = gets.chomp
puts "Enter your option."
name = gets
puts "Hello, " + name
puts "Hi, " + chompname
puts 'But name = ' + name.inspect + ' and chompname = ' + chompname.inspect
=end
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
      else puts "\x1b[1;31mYou entered the wrong command.\x1b[0m\n\r\x1b[31mSelect one of the listed commands.\x1b[0m"
        option_choice
    end
  end
end
