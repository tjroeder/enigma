require_relative './spec_helper'
require_relative '../lib/enigma'

RSpec.describe Enigma do
  let(:enigma) { Enigma.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(enigma).to be_a(Enigma)
    end

    it 'has attributes' do
      expect(enigma.message).to eq('')
      expect(enigma.key).to eq('')
      expect(enigma.offset).to eq('')
    end
  end
end