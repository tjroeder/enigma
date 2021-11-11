module FileIO
  def file_read(file_path)
    file_data = IO.read(file_path)
    file_data.downcase
  end

  def file_write(file_path, new_message)
    file_data = File.write(file_path, new_message)
  end
end