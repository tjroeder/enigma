require_relative '../lib/cipher'

RSpec.describe Cipher do 
  let(:cipher)                 { Cipher.new }
  let(:fake_date)              { '101121' }
  let(:fake_key)               { '12345' }
  let(:fake_offset)            { cipher.offset_creator(fake_date) }
  # let(:fake_shift)             { cipher.shift_creator('00000', '1111', false) }
  let(:cipher_mock)            { double('cipher mock') }

  describe '#initialize' do
    it 'exists' do
      expect(cipher).to be_a(Cipher)
    end

    it 'has attributes' do
      expect(cipher.shift_array).to eq([])
    end
  end

  describe '#key_creator' do
    it 'returns string' do
      expect(cipher.key_creator).to be_a(String)
    end

    it 'can create a string of five digits' do 
      expect(cipher.key_creator).to match(/\d{5}/)
    end

    it 'can return a random 5 digit number string with a stub' do
      allow(cipher).to receive(:key_creator).and_return('12345')
      expect(cipher.key_creator).to eq('12345')
    end
  end
  
  describe '#date_formatter' do
    it 'can return a string of 6 digits' do
      expect(cipher.date_formatter).to match(/\d{6}/)
    end
    
    it 'can return todays date formatted with a stub' do
      allow(cipher_mock).to receive(:date_formatter).and_return('101121')
      expect(cipher_mock.date_formatter).to eq('101121')
    end
  end
  
  describe '#offset_creator' do
    it 'returns string' do
      expect(cipher.offset_creator(fake_date)).to be_a(String)
    end
    
    it 'can create a string of 4 digits' do
      expect(cipher.offset_creator(fake_date)).to match(/\d{4}/)
    end
    
    it 'can square date and return the last four digits' do
      expect(cipher.offset_creator(fake_date)).to eq('6641')
    end
  end
  
  describe '#shift_creator' do
    it 'updates shift array attribute' do
      cipher.shift_creator(fake_key, fake_offset, false)

      expect(cipher.shift_array).to be_a(Array)
    end
    
    it 'updates shift array is 4 digits' do
      cipher.shift_creator(fake_key, fake_offset, false)
      
      expect(cipher.shift_array.size).to eq(4)
    end
    
    it 'can have a negative shift for decryption' do
      cipher.shift_creator(fake_key, fake_offset, true)
      
      expect(cipher.shift_array.all? { |e| e.negative? }).to eq(true)
    end
    
    it 'values are sum of key and offset' do
      fake_a_key = (fake_key[0] + fake_key[1]).to_i
      fake_a_offset = fake_offset[0].to_i
      cipher.shift_creator(fake_key, fake_offset, false)

      expected = fake_a_key + fake_a_offset
      expect(cipher.shift_array[0]).to eq(expected)
      
      fake_b_key = (fake_key[1] + fake_key[2]).to_i
      fake_b_offset = fake_offset[1].to_i

      expected = fake_b_key + fake_b_offset
      expect(cipher.shift_array[1]).to eq(expected)
      
      fake_c_key = (fake_key[2] + fake_key[3]).to_i
      fake_c_offset = fake_offset[2].to_i

      expected = fake_c_key + fake_c_offset
      expect(cipher.shift_array[2]).to eq(expected)
      
      fake_d_key = (fake_key[3] + fake_key[4]).to_i
      fake_d_offset = fake_offset[3].to_i

      expected = fake_d_key + fake_d_offset
      expect(cipher.shift_array[3]).to eq(expected)
    end
  end
end