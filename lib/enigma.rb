require 'date'
require_relative '../mod/file_io'

class Enigma
  include FileIO

  attr_reader :message, :key, :offset

  def initialize
    @message = ''
    @key = ''
    @offset = ''
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
end