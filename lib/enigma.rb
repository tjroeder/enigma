require_relative '../mod/file_io'

class Enigma
  include FileIO

  attr_reader :message, :key, :offset

  def initialize
    @message = ''
    @key = ''
    @offset = ''
  end
end