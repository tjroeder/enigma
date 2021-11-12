require 'date'
require_relative '../mod/file_io'

class Enigma
  include FileIO

  attr_reader :message, :key, :offset, :char_array

  def initialize
    @message = ''
    @key = ''
    @offset = ''
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
    # shift_hash = Hash.new{0}
    # offset.each_with_index do |element, index|
    #   key_offset = key.slice((index)..(index + 1)).to_i + offset[index].to_i
    #   shift_hash[element] = key_offset
    # end
    # shift_hash

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
    offset = offset_creator(date)
    shift_array = shift_creator(key, offset)
    encrypted_message = crypter(message.downcase, shift_array)
    {encryption: encrypted_message, key: key, date: date}
  end
end