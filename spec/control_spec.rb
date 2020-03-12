require_relative '../lib/sequence.rb'
require_relative '../lib/interface.rb'
require_relative '../lib/control.rb'

RSpec.describe Control do
  describe '#menu' do
    it 'string' do
      allow(subject.interface).to receive(:select_menu_option).and_return('set_sequence')

      expect(subject).to receive(:set_sequence)

      subject.menu
    end
    # allow(subject.interface).to receive(:select_menu_option).and_return(:show_sequence)
    # allow(subject.interface).to receive(:select_menu_option).and_return(:generate_sequence)
    # allow(subject.interface).to receive(:select_menu_option).and_return(:exit)
  end
end
