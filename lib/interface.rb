class Interface
  MAIN_MENU = [
    'Main MENU:',
    { title: 'New sequence', action: :create_sequence },
    { title: 'Show sequence elements', action: :show_sequence },
    { title: 'Generate sequence elements', action: :generate_sequence },
    { title: 'Exit', action: :exit }
  ]

  ALGORITHMS_MENU = [
    'Select Algorithm:',
    { title: 'LookAndSay', action: LookAndSay },
    { title: 'Fibonacci', action: Fibonacci }
  ]

  ITERATIONS = (1..10)

  ENTER_SEQUENCE_ELEMENTS       = 'Enter sequence elements:'
  ENTER_NUMBER_OF_ITERATIONS    = 'Enter number of iterations:'
  ENTER_MENU_ACTION             = 'Enter menu action:'
  INPUT_ERROR                   = 'Input error! Try again.'
  SEQUENCE_IS_EMPTY             = 'Sequence is empty!'
  SEQUENCE_ELEMENTS             = 'Sequence elements:'

  def create_sequence
    show_message ENTER_SEQUENCE_ELEMENTS
    gets.chomp.split(' ')
  end

  def set_iteration
    show_message ENTER_NUMBER_OF_ITERATIONS
    loop do
      input = gets.to_i
      return input if ITERATIONS.include?(input)

      input_error
    end
  end

  def enter_menu_action
    show_message(ENTER_MENU_ACTION)
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

  def show_sequence(sequence)
    return show_message(SEQUENCE_IS_EMPTY) if sequence.elements.empty?

    show_message(SEQUENCE_ELEMENTS) do
      sequence.elements.each { |item| puts item }
    end
  end

  def show_menu(menu)
    puts menu.first
    menu.last(menu.size - 1).each.with_index(1) do |hash, index|
      puts "#{index}. #{hash[:title]}"
    end
  end

  def select_menu_option(menu)
    show_menu(menu)
    loop do
      input = enter_menu_action
      return menu[input][:action] if (1..menu.size).include?(input)

      input_error
    end
  end

  def clear
    puts `clear`
  end
end
