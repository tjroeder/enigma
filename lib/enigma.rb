require 'date'
require_relative './cipher'
require_relative '../mod/inputs_outputs'

class Enigma < Cipher
  include InputsOutputs

  attr_reader :char_array
  attr_accessor :cli_key, 
                :cli_date, 
                :cli_message, 
                :cli_read_path, 
                :cli_write_path,
                :new_message

  def initialize
    @cli_key = ''
    @cli_date = ''
    @cli_message = ''
    @cli_read_path = ''
    @cli_write_path = ''
    @new_message = ''
    @char_array = ('a'..'z').to_a.push(' ')
  end

  # Crypt the message using rotating shift array and the char_array
  def crypter(message)
    @new_message = ''
    message.each_char do |char|
      next @new_message.concat(char) unless @char_array.include?(char)
      rotate_amount = @char_array.index(char) + @shift_array[0]
      @new_message.concat(@char_array.rotate(rotate_amount)[0])
      @shift_array.rotate!
    end
  end

  # Encrypt the message using provided or created key and date
  def encrypt(message, key = key_creator, date = date_formatter)
    @cli_key = key
    @cli_date = date
    offset = offset_creator(date)
    shift_creator(key, offset, false)
    crypter(message.downcase)
    {encryption: @new_message, key: key, date: date}
  end
  
  # Decrypt the message using provided or created key and date
  def decrypt(message, key = key_creator, date = date_formatter)
    @cli_key = key
    @cli_date = date
    offset = offset_creator(date)
    shift_creator(key, offset, true)
    crypter(message.downcase)
    {decryption: @new_message, key: key, date: date}
  end
end