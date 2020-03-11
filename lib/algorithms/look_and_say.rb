require_relative '../validation.rb'

class LookAndSay
  extend Validation

  REGEXP = /\d/

  def self.call(elements)
    validate_sequence!(elements: elements, regexp: REGEXP, min_length: 1)

    cluster = []
    elements.last.chars.each do |element|
      expression = cluster.last && cluster.last.last == element
      expression ? cluster.last << element : cluster << [element]
    end

    cluster.map do |cluster_element|
      [cluster_element.count, cluster_element.first]
    end.join
  end
end
