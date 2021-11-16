class Cipher
  attr_accessor :shift_array

  def initialize
    @shift_array = []
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

  def shift_creator(key, offset, decrypt)
    @shift_array = []
    offset.each_char.with_index do |char, index|
      @shift_array.push(char.to_i + key.slice(index..(index + 1)).to_i)
    end
    @shift_array.map! { |e| e * -1 } if decrypt
  end
end