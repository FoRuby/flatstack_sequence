require_relative 'sequence.rb'
require_relative 'interface.rb'

class Control
  attr_reader :sequence, :interface

  def initialize
    @interface = Interface.new
    @sequence = Sequence.new
  end

  def menu
    loop do
      send(interface.select_menu_option(Interface::MAIN_MENU))
    end
  rescue RuntimeError => e
    interface.show_message(e.message)
    retry
  end

  private

  def create_sequence
    interface.clear
    sequence.elements = interface.create_sequence
  end

  def show_sequence
    interface.clear
    interface.show_sequence(sequence)
  end

  def generate_sequence
    interface.clear
    sequence.generate(
      algorithm: interface.select_menu_option(Interface::ALGORITHMS_MENU),
      iteration: interface.set_iteration
    )
  end

  def exit
    interface.show_message('Goodbue!')
    Kernel.exit(true)
  end
end
