# frozen_string_literal: true

module Codebreaker
  class Console
    attr_accessor :player, :game

    COMMANDS = { rules: 'rules',
                 start: 'start',
                 stats: 'stats',
                 exit: 'exit',
                 hint: 'hint' }.freeze

    def start
      puts I18n.t(:welcome)
      options
    end

    def options
      puts I18n.t(:options)
      loop do
        case user_input
        when COMMANDS[:start] then registration
        when COMMANDS[:rules] then rules
        when COMMANDS[:stats] then stats
        else puts I18n.t(:wrong_command)
        end
      end
    end

    private

    def registration
      puts I18n.t(:what_name)
      loop do
        @player = Player.new(user_input)

        next puts(I18n.t(:wrong_name)) unless @player.valid_name?

        difficulty_game = choose_difficulty

        next unless difficulty_game

        @game = Game.new(difficulty_game.level)
        game_state
      end
    end

    def choose_difficulty
      puts I18n.t(:difficulties_menu)
      loop do
        finded_level = Difficult.find(user_input)
        break finded_level if finded_level

        puts I18n.t(:wrong_command)
      end
    end

    def options_game
      puts I18n.t(:game_menu)
      puts I18n.t(:player_used, attempts: @game.attempts, hints: @game.hints)
      puts I18n.t(:player_hints, hints: @game.level_hints) if
      @game.level_hints.size.positive?
    end

    def game_state
      loop do
        options_game
        guess = user_input
        if guess == COMMANDS[:hint]
          next puts(I18n.t(:ended_hints)) unless @game.hints.positive?

          @game.hint
        else
          next puts(I18n.t(:wrong_command)) unless @game.guess_valid(guess)

          @game.guess(guess)

          puts @game.attempt_result.join
          win if @game.guess_won
          loss if @game.guess_loss
        end
      end
    end

    def rules
      puts I18n.t(:rules)
      options
    end

    def stats
      puts Storage.new.load_stats_table
      options
    end

    def exit
      abort I18n.t(:bye)
    end

    def win
      puts I18n.t(:win)
      puts I18n.t(:secret_code, code: @game.secret_code.join)
      puts I18n.t(:do_save)
      @game.save_result_game(@player.name) if user_input == 'y'
      restart
    end

    def loss
      puts I18n.t(:loss)
      puts I18n.t(:secret_code, code: @game.secret_code.join)
      restart
    end

    def restart
      puts I18n.t(:do_play)
      user_input == 'y' ? options : exit
    end

    def user_input
      input = gets.chomp.downcase
      input == COMMANDS[:exit] ? exit : input
    end
  end
end
