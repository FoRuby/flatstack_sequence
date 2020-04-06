require_relative '../validation.rb'

class LookAndSay
  extend Validation

  REGEXP = /\d/

  def self.call(elements)
    validate_sequence!(elements: elements, regexp: REGEXP, min_length: 1)

    string = elements.last.chars
    count = 1
    output = ''
    string.each.with_index do |char, i|
      if char == string[i + 1]
        count += 1
      else
        output += count.to_s + char
        count = 1
      end
    end

    output
  end
end
