require_relative '../lib/validation.rb'

RSpec.describe Validation do
  describe 'validate_sequence!' do
    subject { Class.extend(Validation) }

    it 'should call validate_min_length if min_length attribute precence' do
      allow(subject).to receive(:validate_min_length)

      expect(subject).to receive(:validate_min_length).with(%w[1 22 333], 2)

      subject.validate_sequence!(elements: %w[1 22 333], min_length: 2)
    end

    it 'does not call validate_min_length
        if min_length attribute not precence' do
      expect(subject).to_not receive(:validate_min_length).with(%w[1 22 333], 2)

      subject.validate_sequence!(elements: %w[1 22 333])
    end

    it 'should call validate_content if regexp attribute precence' do
      allow(subject).to receive(:validate_content)

      expect(subject).to receive(:validate_content).with(%w[1 22 333], /\d/)

      subject.validate_sequence!(elements: %w[1 22 333], regexp: /\d/)
    end

    it 'does not call validate_content if regexp attribute not precence' do
      expect(subject).to_not receive(:validate_content).with(%w[1 22 333], /\d/)

      subject.validate_sequence!(elements: %w[1 22 333])
    end
  end
end
