require_relative './enigma'

enigma = Enigma.new
message_path = ARGV[0]
encrypt_path = ARGV[1]
message = enigma.file_read(message_path)
enigma.file_write_path = encrypt_path

encrypted_hash = enigma.encrypt(message)
enigma.file_write(encrypt_path, encrypted_hash[:encryption])

puts enigma.print_message