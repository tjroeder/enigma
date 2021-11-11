module FileIO
  def file_read(file_path)
    file_data = IO.read(file_path)
    file_data.downcase
  end

  def file_write_out(new_message, file_path)
    File.write(file_path.to)
  end
end