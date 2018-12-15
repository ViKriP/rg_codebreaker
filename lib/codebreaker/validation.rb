# frozen_string_literal: true

module Codebreaker
  module Validation
    def validate_string(name, min_value, max_value)
      (!name.empty? && (min_value..max_value).cover?(name.size))
    end

    def validate_number(num:, min_value:, max_value:, length:)
      if num.to_i.instance_of?(Integer) && num.length == length
        num.each_char { |digit| break unless digit.to_i.between?(min_value, max_value) }
      end
    end
  end
end
