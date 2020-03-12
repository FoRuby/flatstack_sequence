require_relative '../lib/algorithms/fibonacci.rb'
require_relative '../lib/algorithms/look_and_say.rb'
require_relative '../lib/sequence.rb'
require_relative '../lib/interface.rb'

RSpec.describe Interface do
  let(:sequence) { Sequence.new(sequence_elements) }
  let(:sequence_elements) { %w[12 345] }
  let(:empty_sequence) { Sequence.new }
  let(:message) { 'test_message' }
  let(:menu) do
    [
      'menu_title',
      { title: 'Title1', action: :menu_action1 },
      { title: 'Title2', action: :menu_action2 }
    ]
  end

  describe '#set_sequence' do
    before { allow(subject).to receive(:gets).and_return('1 2 3') }

    it 'should call show_message' do
      expect(subject).to receive(:show_message)
        .with(Interface::SET_SEQUENCE_ELEMENTS)

      subject.set_sequence
    end

    it 'should call gets and return array of elements' do
      allow(subject).to receive(:show_message)

      expect(subject.set_sequence).to eq %w[1 2 3]
    end
  end

  describe '#set_iteration' do
    before do
      allow(subject).to receive(:gets).and_return('1')
      allow(subject).to receive(:show_message)
    end

    it 'should call show_message' do
      expect(subject).to receive(:show_message)
        .with(Interface::SET_NUMBER_OF_ITERATIONS)

      subject.set_iteration
    end

    context 'valid input' do
      it 'should return input value' do
        expect(subject.set_iteration).to eq 1
      end
    end

    context 'invalid input' do
      it 'out of the interface::ITERATIONS list' do
        allow(subject).to receive(:gets).and_return('123', '2')

        expect(subject).to receive(:show_input_error).once

        subject.set_iteration
      end

      it 'string' do
        allow(subject).to receive(:gets).and_return('foo bar', 1)

        expect(subject).to receive(:show_input_error).once

        subject.set_iteration
      end
    end
  end

  describe '#set_menu_action' do
    before { allow(subject).to receive(:gets).and_return(1) }

    it 'should call show_message' do
      expect(subject).to receive(:show_message)
        .with(Interface::SET_MENU_ACTION)

      subject.set_menu_action
    end

    it 'should call gets and return single integer number' do
      allow(subject).to receive(:show_message)

      expect(subject.set_menu_action).to eq 1
    end
  end

  describe '#show_message' do
    context 'without block' do
      it 'should output message to stdout' do
        expect { subject.show_message(message) }
          .to output(Regexp.new(message)).to_stdout
      end
    end

    context 'with block' do
      it 'should call yield' do
        expect { |block| subject.show_message(message, &block) }
          .to yield_with_no_args
      end

      it 'should output yeld message to stdout' do
        expect { subject.show_message(message) { puts 'foobar' } }
          .to output(Regexp.new('foobar')).to_stdout
      end
    end
  end

  describe '#show_input_error' do
    it 'should call show_message' do
      expect(subject)
        .to receive(:show_message).with(Interface::SHOW_INPUT_ERROR)

      subject.show_input_error
    end
  end

  describe '#show_sequence(sequence)' do
    context 'empty sequence' do
      it 'should call show_message' do
        expect(subject).to receive(:show_message)
          .with(Interface::SEQUENCE_IS_EMPTY)

        subject.show_sequence(empty_sequence)
      end
    end

    context 'not empty sequence' do
      it 'should call show_message' do
        expect(subject).to receive(:show_message)
          .with(Interface::SEQUENCE_ELEMENTS)

        subject.show_sequence(sequence)
      end

      it 'should output sequence elements to stdout' do
        sequence_elements.each do |element|
          expect { subject.show_sequence(sequence) }
            .to output(Regexp.new(element)).to_stdout
        end
      end
    end
  end

  describe '#show_menu(menu)' do
    it 'should output menu title to stdout' do
      expect { subject.show_menu(menu) }
        .to output(Regexp.new('menu_title')).to_stdout
    end

    it 'should output each content title to stdout' do
      menu.last(menu.size - 1).each do |hash|
        expect { subject.show_menu(menu) }
          .to output(Regexp.new(hash[:title].to_s)).to_stdout
      end
    end
  end

  describe '#select_menu_option(menu)' do
    before do
      allow(subject).to receive(:set_menu_action).and_return(1)
      allow(subject).to receive(:show_menu)
    end

    it 'should call show_menu(menu)' do
      expect(subject).to receive(:show_menu).with(menu)

      subject.select_menu_option(menu)
    end

    it 'should call set_menu_action and return input' do
      expect(subject).to receive(:set_menu_action).and_return(1)

      subject.select_menu_option(menu)
    end

    context 'valid input' do
      it 'should return menu action' do
        allow(subject).to receive(:set_menu_action).and_return(1)

        expect(subject.select_menu_option(menu)).to eq menu[1][:action]
      end
    end

    context 'invalid input' do
      it 'out of the number of menu options' do
        allow(subject).to receive(:set_menu_action).and_return(10, 1)

        expect(subject).to receive(:show_input_error).once

        subject.select_menu_option(menu)
      end

      it 'string' do
        allow(subject).to receive(:set_menu_action).and_return('foo bar', 1)

        expect(subject).to receive(:show_input_error).once

        subject.select_menu_option(menu)
      end
    end
  end
end
