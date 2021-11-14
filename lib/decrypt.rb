require_relative './enigma'

enigma = Enigma.new
message_path = ARGV[0]
decrypt_path = ARGV[1]
cli_key = ARGV[2]
cli_date = ARGV[3]
message = enigma.file_read(message_path)
enigma.file_write_path = decrypt_path

decrypted_hash = enigma.decrypt(message, cli_key, cli_date)
enigma.file_write(decrypt_path, decrypted_hash[:encryption])

puts enigma.print_message