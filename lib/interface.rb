class Interface
  MAIN_MENU = {
    create_sequence:   'New sequence',
    show_sequence:     'Show sequence elements',
    generate_sequence: 'Generate sequence elements',
    exit:              'Exit'
  }

  ALGORITHMS = {
    look_and_say: LookAndSay,
    fibonacci:    Fibonacci
  }

  ENTER_SEQUENCE_ELEMENTS = 'Enter sequence elements:'
  NUMBER_OF_ITERATIONS    = 'Number of iterations:'
  INPUT_ERROR             = 'Input error!'
  SEQUENCE_IS_EMPTY       = 'Sequence is empty!'
  SEQUENCE_ELEMENTS       = 'Sequence elements:'

  def create_sequence
    show_message ENTER_SEQUENCE_ELEMENTS
    gets.chomp.split(' ')
  end

  def set_iteration
    show_message NUMBER_OF_ITERATIONS
    gets.to_i
  end

  def enter_action
    gets.to_i
  end

  def input_error
    show_message INPUT_ERROR
  end

  def show_message(message)
    puts '-------------------------'
    puts message
    yield if block_given?
    puts '-------------------------'
  end

  def show_menu(menu, title = nil)
    puts title if title
    menu.each_value.with_index(1) do |value, index|
      puts "#{index}. #{value}"
    end
  end

  def show_main_menu
    loop do
      show_menu(MAIN_MENU, 'Main MENU:')
      case enter_action
      when 1 then return MAIN_MENU.key('New sequence')
      when 2 then return MAIN_MENU.key('Show sequence elements')
      when 3 then return MAIN_MENU.key('Generate sequence elements')
      when 4 then return MAIN_MENU.key('Exit')
      else input_error
      end
    end
  end

  def show_algorithms_menu
    loop do
      show_menu(ALGORITHMS, 'Select Algorithm:')
      case enter_action
      when 1 then return ALGORITHMS[:look_and_say]
      when 2 then return ALGORITHMS[:fibonacci]
      else input_error
      end
    end
  end

  def show_sequence(sequence)
    return show_message(SEQUENCE_IS_EMPTY) if sequence.elements.empty?

    show_message(SEQUENCE_ELEMENTS) do
      sequence.elements.each { |item| puts item }
    end
  end
end
