require_relative './spec_helper'
require_relative '../lib/enigma'

RSpec.describe Enigma do
  let(:fixture_message_path)   { './spec/fixtures/message.txt' }
  let(:fixture_encrypted_path) { './spec/fixtures/encrypted.txt' }
  let(:fixture_decrypted_path) { './spec/fixtures/decrypted.txt' }
  let(:fake_date)              { '101121' }
  let(:fake_key)               { '12345' }
  let(:enigma)                 { Enigma.new }
  let(:message_str)            { enigma.file_read(fixture_message_path) }
  let!(:fake_offset)            { enigma.offset_creator(fake_date) }
  let!(:fake_shift)             { enigma.shift_creator('00000', '1111', false) }
  
  
  describe '#initialize' do
    it 'exists' do
      expect(enigma).to be_a(Enigma)
    end

    it 'has attributes' do
      expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

      expect(enigma.cli_key).to eq('')
      expect(enigma.cli_date).to eq('')
      expect(enigma.cli_message).to eq('')
      expect(enigma.cli_read_path).to eq('')
      expect(enigma.cli_write_path).to eq('')
      expect(enigma.new_message).to eq('')
      expect(enigma.char_array).to eq(expected)
    end
  end

  describe 'InputsOutputs module' do
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

    describe '#cli_user_input' do
      let(:encrypt_arg_array) { ['message.txt', 'encrypted.txt'] }
      let(:decrypt_arg_array) { ['encrypted.txt', 'decrypted.txt', '82648', '240818'] }

      it 'can take in two CLI inputs from array' do        
        enigma.cli_user_input(encrypt_arg_array)

        expect(enigma.cli_read_path).to eq(encrypt_arg_array[0])
        expect(enigma.cli_write_path).to eq(encrypt_arg_array[1])
      end

      it 'can take in four CLI inputs from array' do        
        enigma.cli_user_input(decrypt_arg_array)

        expect(enigma.cli_read_path).to eq(decrypt_arg_array[0])
        expect(enigma.cli_write_path).to eq(decrypt_arg_array[1])
        expect(enigma.cli_write_path).to eq(decrypt_arg_array[1])
        expect(enigma.cli_write_path).to eq(decrypt_arg_array[1])
      end
    end

    describe '#cli_print_message' do
      it 'can print message with encrypt text output' do
        arg_array = ['message.txt', 'encrypted.txt', '12345', '101121']
        enigma.cli_user_input(arg_array)
        expected = "Created 'encrypted.txt' with key 12345 and date 101121" 
        expect(enigma.cli_print_message).to eq(expected)
      end
      
      it 'can print message with decrypt text output' do
        arg_array = ['encrypted.txt', 'decrypted.txt', '12345', '101121']
        enigma.cli_user_input(arg_array)
        expected = "Created 'decrypted.txt' with key 12345 and date 101121" 
        expect(enigma.cli_print_message).to eq(expected)
      end
    end
  end

  describe 'Enigma class methods' do
    describe '#crypter' do
      it 'sets new_message to same length of original message' do
        enigma.crypter(message_str)
        
        expected = message_str.size
        expect(enigma.new_message.length).to eq(expected)
      end
      
      it 'can take a message and return it shifted' do
        enigma.crypter('hello')

        expected = 'ifmmp'
        expect(enigma.new_message).to eq(expected)
      end
      
      it 'can skip special characters' do
        enigma.crypter('h3!1() qwerty')

        expected = 'i3!1()arxfsuz'
        expect(enigma.new_message).to eq(expected)
      end
      
      it 'can shift with different a, b, c, d values then repeat' do
        enigma.shift_array = [1, 2, 3, 4]
        enigma.crypter('hello')

        expect(enigma.new_message).to eq('igopp')
      end
      
      it 'can shift back to the same character' do
        enigma.shift_array = [27, 27, 27, 27]
        enigma.crypter('hello')

        expect(enigma.new_message).to eq('hello')
      end
      
      it 'will return same message if all special characters' do
        enigma.crypter("1$\n&*()")

        expect(enigma.new_message).to eq("1$\n&*()")
      end
    end
    
    describe '#encrypt' do
      it 'returns hash' do
        expect(enigma.encrypt('hello', fake_key, fake_date)).to be_a(Hash)
      end
      
      it 'hash has three keys with strings' do
        encrypt_hash = enigma.encrypt('hello', fake_key, fake_date)

        expect(encrypt_hash[:encryption]).to be_a(String)
        expect(encrypt_hash[:key]).to be_a(String)
        expect(encrypt_hash[:date]).to be_a(String)
      end
      
      it 'can return a encrypted message' do
        encrypt_hash = enigma.encrypt('hello', fake_key, fake_date)

        expect(encrypt_hash[:encryption]).to eq('zgwdf')
      end
      
      it 'can return a key' do
        encrypt_hash = enigma.encrypt('hello', fake_key, fake_date)

        expect(encrypt_hash[:key]).to eq(fake_key)
      end
      
      it 'can return a date' do
        encrypt_hash = enigma.encrypt('hello', fake_key, fake_date)

        expect(encrypt_hash[:date]).to eq(fake_date)
      end
      
      it 'can return the current date if not given' do
        allow(enigma).to receive(:date_formatter).and_return('101121')
        encrypt_hash = enigma.encrypt('hello', fake_key)

        expect(encrypt_hash[:key]).to eq('12345')
      end
      
      it 'can return both random key and current date if not given' do
        allow(enigma).to receive(:key_creator).and_return('12345')
        allow(enigma).to receive(:date_formatter).and_return('101121')
        encrypt_hash = enigma.encrypt('hello')

        expect(encrypt_hash[:key]).to eq('12345')
        expect(encrypt_hash[:date]).to eq('101121')
      end
    end

    describe '#decrypt' do
      it 'returns hash' do
        expect(enigma.decrypt('zgwdf', fake_key, fake_date)).to be_a(Hash)
      end
      
      it 'hash has three keys with strings' do
        decrypt_hash = enigma.decrypt('zgwdf', fake_key, fake_date)

        expect(decrypt_hash[:decryption]).to be_a(String)
        expect(decrypt_hash[:key]).to be_a(String)
        expect(decrypt_hash[:date]).to be_a(String)
      end
      
      it 'can return a decrypted message' do
        decrypt_hash = enigma.decrypt('zgwdf', fake_key, fake_date)

        expect(decrypt_hash[:decryption]).to eq('hello')
      end
      
      it 'can return a key' do
        decrypt_hash = enigma.decrypt('zgwdf', fake_key, fake_date)

        expect(decrypt_hash[:key]).to eq(fake_key)
      end
      
      it 'can return a date' do
        decrypt_hash = enigma.decrypt('zgwdf', fake_key, fake_date)

        expect(decrypt_hash[:date]).to eq(fake_date)
      end
      
      it 'can return the current date if not given' do
        allow(enigma).to receive(:date_formatter).and_return('101121')
        decrypt_hash = enigma.decrypt('zgwdf', fake_key)

        expect(decrypt_hash[:key]).to eq('12345')
      end
      
      it 'can return both random key and current date if not given' do
        allow(enigma).to receive(:key_creator).and_return('12345')
        allow(enigma).to receive(:date_formatter).and_return('101121')
        decrypt_hash = enigma.decrypt('zgwdf')

        expect(decrypt_hash[:key]).to eq('12345')
        expect(decrypt_hash[:date]).to eq('101121')
      end
    end
  end
end