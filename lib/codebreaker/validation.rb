# frozen_string_literal: true

module Codebreaker
  module Validation
    def validate_string(name, min_value, max_value)
      (!name.empty? && (min_value..max_value).cover?(name.size))
    end

    def validate_digit_between?(num, min_value, max_value)
      num.each_char do |digit|
        break unless digit.to_i.between?(min_value, max_value)
      end
    end
  end
end
