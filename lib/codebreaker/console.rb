# frozen_string_literal: true

module Codebreaker
  class Console
    attr_accessor :tmp_secret_code, :player, :game
    
    def start
      puts I18n.t(:welcome)
      options
    end
     
    def options
      puts I18n.t(:options)
      case gets.chomp
        when I18n.t(:command_start) then registration
        when I18n.t(:command_rules) then rules
        when I18n.t(:command_stats) then stats
        when I18n.t(:command_exit) then exit
        else puts I18n.t(:wrong_command)      
          options
      end
    end
    
    def registration      
      puts I18n.t(:what_name)  
      @player = Player.new(gets.chomp)

      @player.valid_name? ? difficulties : puts(I18n.t(:wrong_name))
      registration
    end    

    def difficulties
      puts I18n.t(:difficulties_menu)
      case gets.chomp
        when I18n.t('difficulty_1.name') then @game = Game.new(I18n.t('difficulty_1'))
        when I18n.t('difficulty_2.name') then @game = Game.new(I18n.t('difficulty_2'))
        when I18n.t('difficulty_3.name') then @game = Game.new(I18n.t('difficulty_3'))
        when I18n.t(:command_exit) then exit
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
        when I18n.t(:command_hint) then @game.hints != 0 ? @game.hint : puts(I18n.t(:ended_hints))
        when I18n.t(:command_exit) then exit
        else @game.guess_valid(guess) ? @game.guess(guess) : puts(I18n.t(:wrong_command))
      end

      if @game.attempts <= 0
        puts I18n.t(:ended_attempts)
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
      puts Storage.new.load_stats_table
      options
    end
    
    def win
      puts I18n.t(:win)
      puts I18n.t(:secret_code, code: @game.secret_code.join)      
      puts I18n.t(:do_save)
      @game.save_result_game(@player.name) if gets.chomp == 'y'
      puts I18n.t(:do_play)
      gets.chomp == 'y' ? options : exit
    end
    
    def exit
      abort I18n.t(:bye)
    end
  end
end