module InputsOutputs
  # Read in file from given file path
  def file_read(file_path)
    file_data = IO.read(file_path)
    file_data.downcase
  end
  
  # Write to file with given file path and new message
  def file_write(file_path, new_message)
    file_data = File.write(file_path, new_message)
  end

  # Take in and save CLI arguments
  def cli_user_input(arg_array)
    @cli_read_path = arg_array[0]
    @cli_write_path = arg_array[1]
    @cli_message = file_read(@cli_read_path)
    if arg_array.length == 3
      @cli_key = arg_array[2] 
      @cli_date = date_formatter
    end
    @cli_date = arg_array[3] if arg_array.length == 4
  end

  # Create print message for the CLI commands
  def cli_print_message
    "Created '#{cli_write_path}' with key #{cli_key} and date #{cli_date}"
  end
end