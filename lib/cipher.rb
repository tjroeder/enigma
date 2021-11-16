class Cipher
  attr_accessor :shift_array

  def initialize
    @shift_array = []
  end

  # Return random 5 digit number
  def key_creator
    rand(99999).to_s.rjust(5, '0')
  end

  # Return todays date in DDMMYY format
  def date_formatter
    Date.today.strftime('%d''%m''%y')
  end

  # Create offset from the date squared and return last 4 digits as string
  def offset_creator(date)
    cur_date = date.to_i ** 2
    cur_date.to_s.slice(-4..-1)
  end

  # Create ABCD shifts from key, and offset, negate the shift if decrypt = true
  def shift_creator(key, offset, decrypt)
    @shift_array = []
    offset.each_char.with_index do |char, index|
      @shift_array.push(char.to_i + key.slice(index..(index + 1)).to_i)
    end
    @shift_array.map! { |e| e * -1 } if decrypt
  end
end