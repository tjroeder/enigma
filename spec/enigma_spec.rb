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

  describe 'Enigma class methods' do
    describe '#key_creator' do
      it 'is a string' do
        expect(enigma.key_creator).to be_a(String)
      end

      it 'can create a string of length 5' do
        expect(enigma.key_creator.length).to eq(5)
      end

      it 'can create a string of five digits' do 
        expect(enigma.key_creator).to match(/\d{5}/)
      end
    end

    describe '#offset_creator' do
      it 'is a string' do
        expect(enigma.offset_creator).to be_a(String)
      end

      it 'can create a string of length 4' do
        expect(enigma.offset_creator.length).to eq(4)
      end

      it 'can create a string of 4 digits' do
        expect(enigma.offset_creator).to match(/\d{4}/)
      end
    end
  end

end