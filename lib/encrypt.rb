require_relative './enigma'

enigma = Enigma.new
enigma.cli_user_input(ARGV)
encrypted_hash = enigma.encrypt(enigma.cli_message)
enigma.file_write(enigma.cli_write_path, encrypted_hash[:encryption])

puts enigma.cli_print_message