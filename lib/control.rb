require_relative 'sequence.rb'
require_relative 'interface.rb'

class Control
  attr_reader :sequence, :interface

  def initialize
    @interface = Interface.new
    @sequence = Sequence.new
  end

  def menu
    loop { send(interface.show_main_menu) }
  rescue RuntimeError => e
    interface.show_message(e.message)
    retry
  end

  private

  def create_sequence
    @sequence.elements = interface.create_sequence
  end

  def show_sequence
    interface.show_sequence(sequence)
  end

  def generate_sequence
    sequence.generate(
      algorithm: interface.show_algorithms_menu,
      iteration: interface.set_iteration
    )
  end

  def exit
    interface.show_message('Goodbue!')
    Kernel.exit(true)
  end
end
