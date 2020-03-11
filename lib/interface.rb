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

  def create_sequence
    puts '-------------------------'
    puts 'Enter sequence elements: '
    puts '-------------------------'
    gets.chomp.split(' ')
  end

  def set_iteration
    puts '-------------------------'
    puts '  Number of iterations:  '
    puts '-------------------------'
    gets.to_i
  end

  def enter_action
    gets.to_i
  end

  def input_error
    puts '-------------------------'
    puts '      Input error!       '
    puts '-------------------------'
  end

  def show_message(message)
    puts '-------------------------'
    puts message
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
    puts '-------------------------'
    if sequence.elements.empty?
      puts '   Sequence is empty!    '
    else
      puts '   Sequence elements:    '
      sequence.elements.each { |item| puts item }
    end
    puts '-------------------------'
  end
end
