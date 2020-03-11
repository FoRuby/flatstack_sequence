require_relative './algorithms/look_and_say.rb'
require_relative './algorithms/fibonacci.rb'

class Sequence
  attr_accessor :elements

  def initialize(elements = [])
    @elements = elements
  end

  def generate(algorithm:, iteration:)
    iteration.times do
      @elements << algorithm.call(elements)
    end
  end
end
