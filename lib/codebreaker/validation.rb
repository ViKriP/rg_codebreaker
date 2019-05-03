# frozen_string_literal: true

module Codebreaker
  module Validation
    def validate_string(name, range_size_string)
      (!name.empty? && range_size_string.cover?(name.size))
    end

    def validate_digit_between?(num, digits_allowed)
      num.each_char do |digit|
        break unless digits_allowed.include?(digit.to_i)
      end
    end
  end
end
