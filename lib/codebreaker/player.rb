# frozen_string_literal: true

module Codebreaker
  class Player
    include Validation
    attr_accessor :name

    MIN_SIZE_STRING = 3
    MAX_SIZE_STRING = 20
    RANGE_SIZE_STRING = (MIN_SIZE_STRING..MAX_SIZE_STRING).freeze

    def initialize(name)
      @name = name
    end

    def valid_name?
      validate_string(@name, RANGE_SIZE_STRING)
    end
  end
end
