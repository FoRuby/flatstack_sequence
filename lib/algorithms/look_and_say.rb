require_relative '../validation.rb'

class LookAndSay
  extend Validation

  REGEXP = /\d/

  def self.call(elements)
    validate_sequence!(elements: elements, regexp: REGEXP, min_length: 1)
  
    elements.last.chars.chunk(&:itself)
                       .map{ |element, arr| [arr.size, element] }
                       .join
  end
end

