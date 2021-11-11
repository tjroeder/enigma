require_relative './spec_helper'
require_relative '../lib/enigma'

RSpec.describe Enigma do
  let(:fixture_message_path) { './spec/fixtures/message.txt' }
  let(:fixture_encrypted_path) { './spec/fixtures/encrypted.txt' }
  let(:fixture_decrypted_path) { './spec/fixtures/decrypted.txt' }
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

  describe 'file_io module' do
    describe '#file_read' do
      it 'can read a file name and convert to downcase string' do
        expected = "this is a string for testing\nthis is a second line\nth1s line h4$ `1234567890-=[]\\;',./~!@\#$%^&*()_+{}|:\"<>? special characters\nthis is the final line!"

        expect(enigma.file_read(fixture_message_path)).to eq(expected)
      end
    end

    describe '#file_write' do
      it 'can write a new message to a file name' do
        new_message = "this is a string for testing\nthis is a second line\nth1s line h4$ `1234567890-=[]\\;',./~!@\#$%^&*()_+{}|:\"<>? special characters\nthis is the final line!"
        enigma.file_write(fixture_decrypted_path, new_message)

        expect(enigma.file_read(fixture_decrypted_path)).to eq(new_message)
      end
    end
  end
end