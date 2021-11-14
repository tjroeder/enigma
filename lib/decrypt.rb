require_relative './enigma'

enigma = Enigma.new
enigma.cli_user_input(ARGV)
decrypted_hash = enigma.decrypt(enigma.cli_message, enigma.cli_key, enigma.cli_date)
enigma.file_write(enigma.cli_write_path, decrypted_hash[:encryption])

puts enigma.cli_print_message