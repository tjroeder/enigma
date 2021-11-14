require 'date'
require_relative '../mod/file_io'

class Enigma
  include FileIO

  attr_reader :char_array
  attr_accessor :key, :date, :print_message, :file_write_path

  def initialize
    @key = ''
    @date = ''
    @offset = ''
    @print_message = ''
    @file_write_path = ''
    @char_array = ('a'..'z').to_a.push(' ')
  end
  
  def key_creator
    rand(99999).to_s.rjust(5, '0')
  end

  def date_formatter
    Date.today.strftime('%d''%m''%y')
  end

  def offset_creator(date)
    cur_date = date.to_i ** 2
    cur_date.to_s.slice(-4..-1)
  end

  def shift_creator(key, offset)
    shift_array = []
    offset.each_char.with_index do |char, index|
      shift_array.push(char.to_i + key.slice(index..(index + 1)).to_i)
    end
    shift_array
  end

  def crypter(message, shift_array)
    new_message = ''
    message.each_char do |char|
      next new_message.concat(char) unless @char_array.include?(char)
      rotate_amount = @char_array.index(char) + shift_array[0]
      new_message.concat(@char_array.rotate(rotate_amount)[0])
      shift_array.rotate!
    end
    new_message
  end

  def encrypt(message, key = key_creator, date = date_formatter)
    @key = key
    @date = date
    offset = offset_creator(@date)
    @print_message = "Created '#{@file_write_path}' with key #{@key} and date #{@date}"
    shift_array = shift_creator(@key, offset)
    encrypted_message = crypter(message.downcase, shift_array)
    {encryption: encrypted_message, key: key, date: date}
  end

  def decrypt(message, key = key_creator, date = date_formatter)
    @key = key
    @date = date
    offset = offset_creator(@date)
    @print_message = "Created '#{@file_write_path}' with key #{@key} and date #{@date}"
    shift_array = shift_creator(@key, offset).map{ |e| e * -1 }
    decrypted_message = crypter(message.downcase, shift_array)
    {encryption: decrypted_message, key: @key, date: @date}
  end
end