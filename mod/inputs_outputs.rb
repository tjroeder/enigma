module InputsOutputs
  def file_read(file_path)
    file_data = IO.read(file_path)
    file_data.downcase
  end

  def file_write(file_path, new_message)
    file_data = File.write(file_path, new_message)
  end

  def cli_user_input(arg_array)
    @cli_read_path = arg_array[0]
    @cli_write_path = arg_array[1]

    # need to fix if the message is nil put in guard check.
    @cli_message = file_read(@cli_read_path)
    # need to check key and date 
    @cli_key = arg_array[2] if arg_array.length >= 3
    @cli_date = arg_array[3] if arg_array.length == 4
  end
end