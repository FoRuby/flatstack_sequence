require_relative '../lib/algorithms/fibonacci.rb'
require_relative '../lib/algorithms/look_and_say.rb'
require_relative '../lib/sequence.rb'
require_relative '../lib/interface.rb'

RSpec.describe Interface do
  let(:sequence) { Sequence.new(sequence_elements) }
  let(:sequence_elements) { %w[12 345] }
  let(:empty_sequence) { Sequence.new }
  let(:message) { 'test_message' }
  let(:menu) { { option_1: 'Option 1', option_2: 'Option 2' } }

  describe '#show_message' do
    it 'should output message to stdout' do
      expect { subject.show_message(message) }
        .to output(Regexp.new(message)).to_stdout
    end
  end

  describe '#input_error' do
    it 'should call show_message' do
      expect(subject).to receive(:show_message).with(Interface::INPUT_ERROR)

      subject.input_error
    end

    it 'should output message to stdout' do
      expect { subject.input_error }
        .to output(Regexp.new(Interface::INPUT_ERROR)).to_stdout
    end
  end

  describe '#create_sequence' do
    before { allow(subject).to receive(:gets).and_return('1 2 3') }

    it 'should call show_message' do
      expect(subject).to receive(:show_message)
        .with(Interface::ENTER_SEQUENCE_ELEMENTS)

      subject.create_sequence
    end

    it 'should output message to stdout' do
      expect { subject.create_sequence }
        .to output(Regexp.new(Interface::ENTER_SEQUENCE_ELEMENTS)).to_stdout
    end

    it 'should call gets and return array of elements' do
      allow(subject).to receive(:show_message)

      expect(subject.create_sequence).to eq %w[1 2 3]
    end
  end

  describe '#show_sequence(sequence)' do
    context 'empty sequence' do
      it 'should call show_message' do
        expect(subject).to receive(:show_message)
          .with(Interface::SEQUENCE_IS_EMPTY)

        subject.show_sequence(empty_sequence)
      end

      it 'should output message to stdout' do
        expect { subject.show_sequence(empty_sequence) }
          .to output(Regexp.new(Interface::SEQUENCE_IS_EMPTY)).to_stdout
      end
    end

    context 'not empty sequence' do
      it 'should call show_message' do
        expect(subject).to receive(:show_message)
          .with(Interface::SEQUENCE_ELEMENTS)

        subject.show_sequence(sequence)
      end

      it 'should output message to stdout' do
        expect { subject.show_sequence(sequence) }
          .to output(Regexp.new(Interface::SEQUENCE_ELEMENTS)).to_stdout
      end

      it 'should output sequence elements to stdout' do
        sequence_elements.each do |element|
          expect { subject.show_sequence(sequence) }
            .to output(Regexp.new(element)).to_stdout
        end
      end
    end
  end

  describe '#show_menu(menu, title)' do
    it 'should output title to stdout' do
      expect { subject.show_menu(menu, 'menu_title') }
        .to output(Regexp.new('menu_title')).to_stdout
    end

  end
end
