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
end