# frozen_string_literal: true

module Codebreaker
  class Console
    include Validation
    attr_accessor :tmp_secret_code, :player, :game
    
    def start
      puts I18n.t(:welcome)
      options
    
      #STDOUT.flush
    end
     
    def options
      puts I18n.t(:options)
      case gets.chomp
        when 'start' then registration
        when 'rules' then rules
        when 'stats' then stats
        when 'exit' then exit
        else puts I18n.t(:wrong_command)      
          options
      end
    end
    
    def registration
      puts I18n.t(:what_name)  
      @player = Player.new(gets.chomp)
      
      #puts "Your name \x1b[36m#{@player.name}\x1b[0m"
      @player.valid_name? ? difficulties : puts(I18n.t(:wrong_name))
      
      registration
    end

    def difficulties
      puts I18n.t(:difficulties_menu)
      case gets.chomp
        when 'easy' then @game = Game.new('easy', 3, 2) 
        when 'medium' then @game = Game.new('medium', 10, 1)
        when 'hell' then @game = Game.new('hell', 5, 1)
        when 'exit' then exit
        else puts I18n.t(:wrong_command)
          difficulties
      end
      options_game
    end
    
    def options_game 
      puts I18n.t(:game_menu)
      puts I18n.t(:player_used, attempts: @game.attempts, hints: @game.hints)
      puts(I18n.t(:player_hints, hints: @game.level_hints)) if @game.level_hints.size > 0      

      guess = gets.chomp

      case guess
        when 'hint' then @game.hints != 0 ? @game.hint : puts(I18n.t(:ended_hints))
        when 'exit' then exit
        else guess_valid(guess) ? @game.guess(guess) : puts(I18n.t(:wrong_command))
      end

      if @game.attempts <= 0
        puts(I18n.t(:ended_attempts))
        puts I18n.t(:loss)
        puts I18n.t(:secret_code, code: @game.secret_code.join)
        difficulties
      end
      
      puts @game.attempt_result
    
      win if @game.attempt_result == Array.new(4, '+')
    
      options_game
    end
    
    def rules
      puts I18n.t(:rules)
      options
    end
    
    def stats
      # TODO - stats
      puts "Den 5 jjjdkfl 676 dfd"
      options
    end
    
    def win
      puts I18n.t(:win)
      # TODO - Start new or arh db or exit
      Storage.new.save
      exit
    end
    
    def exit      
      #exit
      abort I18n.t(:bye)
    end

    private

    def guess_valid(num)
      validate_number(num: num, min_value: 1, max_value: 6, length: 4)
    end
  end
end