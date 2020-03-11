require_relative '../lib/sequence.rb'

RSpec.describe Sequence do
  let(:elements) { ['22', '122'] }
  let(:new_elements) { ['33', '233'] }
  let(:iteration) { 2 }
  let!(:sequence) { Sequence.new(elements) }


  describe '#elements=' do
    it 'should assign new_elements to @elements' do
      sequence.elements = new_elements

      expect(sequence.elements).to eq ['33', '233']
    end
  end

  describe '#elements' do
    it 'should return @elements content' do
      expect(sequence.elements).to eq ['22', '122']
    end
  end

  describe '#generate' do
    context 'Fibonacci' do
      it "should call 'generate' with appropriate arguments" do
        expect(Fibonacci).to receive(:call).with(elements)
                                           .exactly(iteration)
                                           .times

        sequence.generate(algorithm: Fibonacci, iteration: iteration)
      end

      it 'should add Fibonacci.call(elements) results to @elements' do
        allow(Fibonacci).to receive(:call).and_return('stub')

        sequence.generate(algorithm: Fibonacci, iteration: iteration)

        expect(sequence.elements).to eq ['22', '122', 'stub', 'stub']
      end
    end

    context 'LookAndSay' do
      it "should call 'generate' with appropriate arguments" do
        expect(LookAndSay).to receive(:call).with(elements)
                                            .exactly(iteration)
                                            .times

        sequence.generate(algorithm: LookAndSay, iteration: iteration)
      end

      it 'should add LookAndSay.call(elements) results to @elements' do
        allow(LookAndSay).to receive(:call).and_return('stub')

        sequence.generate(algorithm: LookAndSay, iteration: iteration)

        expect(sequence.elements).to eq ['22', '122', 'stub', 'stub']
      end
    end
  end
end
