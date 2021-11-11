require 'date'
require_relative '../mod/file_io'

class Enigma
  include FileIO

  attr_reader :message, :key, :offset

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

  def offset_creator(date = date_formatter)
    cur_date = date.to_i ** 2
    cur_date.to_s.slice(-4..-1)
  end

  def shift_creator(key, offset)
    shift_hash = Hash.new{0}
    [:a, :b, :c, :d].each_with_index do |element, index|
      key_offset = key.slice((index)..(index + 1)).to_i + offset[index].to_i
      shift_hash[element] = key_offset
    end
    shift_hash
  end
end