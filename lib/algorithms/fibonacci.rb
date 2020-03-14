require_relative '../validation.rb'

class Fibonacci
  extend Validation

  REGEXP = /\d/

  def self.call(elements)
    validate_sequence!(elements: elements, regexp: REGEXP, min_length: 2)

    result = elements[-1].to_i + elements[-2].to_i
    result.to_s
  end
end
