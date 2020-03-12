require_relative '../lib/algorithms/look_and_say.rb'

RSpec.describe LookAndSay do
  let(:elements1) { ['11', '122333'] }
  let(:invalid_elements1) { [] }
  let(:invalid_elements2) { [11, 122333] }
  let(:invalid_elements3) { ['foo', 'bar'] }

  describe '.call' do
    subject { LookAndSay }

    it "LookAndSay.call(['11', '122333']) => 112233" do
      expect(subject.call(elements1)).to eq '112233'
    end

    it 'LookAndSay.call([]) => Invalid sequence length' do
      expect { subject.call(invalid_elements1) }
        .to raise_error(RuntimeError, 'Invalid sequence length')
    end

    it 'LookAndSay.call([11, 122333]) => Invalid sequence content' do
      expect { subject.call(invalid_elements2) }
        .to raise_error(RuntimeError, 'Invalid sequence content')
    end

    it "LookAndSay.call(['foo', 'bar']) => Invalid sequence content" do
      expect { subject.call(invalid_elements3) }
        .to raise_error(RuntimeError, 'Invalid sequence content')
    end
  end
end
