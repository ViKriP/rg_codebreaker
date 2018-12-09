# frozen_string_literal: true

module Codebreaker
  class Player
    include Validation
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def valid_name?
      validate_name(@name, 3, 20)
    end
  end
end
