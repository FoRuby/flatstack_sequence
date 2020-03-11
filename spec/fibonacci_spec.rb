require_relative '../lib/algorithms/fibonacci.rb'

RSpec.describe Fibonacci do
  let(:sequence1) { ['1', '2', '3'] }
  let(:invalid_sequence1) { ['1'] }
  let(:invalid_sequence2) { ['foo', 'bar'] }
  let(:invalid_sequence3) { [1, 2] }

  describe '.call' do
    it "Fibonacci.call(['1', '2', '3']) => 5" do
      expect(Fibonacci.call(sequence1)).to eq '5'
    end

    it "Fibonacci.call(['foo', 'bar']) => Invalid sequence length" do
      expect { Fibonacci.call(invalid_sequence1) }
        .to raise_error(RuntimeError, 'Invalid sequence length')
    end

    it "Fibonacci.call(['1']) => Invalid sequence content" do
      expect { Fibonacci.call(invalid_sequence2) }
        .to raise_error(RuntimeError, 'Invalid sequence content')
    end

    it 'Fibonacci.call([1, 2]) => Invalid sequence type' do
      expect { Fibonacci.call(invalid_sequence3) }
        .to raise_error(RuntimeError, 'Invalid sequence content')
    end
  end
end
