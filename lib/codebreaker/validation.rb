# frozen_string_literal: true

module Validation
  def validate_name(name, min_value, max_value)
#puts "---------- #{name} --- #{!validate_empty(name)} --- #{(min_value..max_value).cover?(name.size)}"
#    name.is_a?(String)
    (!name.empty? && (min_value..max_value).cover?(name.size))
  end

  def validate_number(num:, min_value:, max_value:, length:)
#puts "num --- #{num.to_i.instance_of?(Integer)} ----- #{num.length == length}"
    if num.to_i.instance_of?(Integer) && num.length == length
      num.each_char { |digit| break unless digit.to_i.between?(min_value, max_value) }
    end
  end
end
