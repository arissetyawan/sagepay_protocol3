require 'openssl'

module SagepayProtocol3

  module Encryption
    extend self

    def cipher(operation, cipher, cipher_key)
      lambda do |cipher, data, padding|
        c = OpenSSL::Cipher.new(cipher)
        c.send(operation)
        c.padding = padding
        c.key = cipher_key
        c.iv = cipher_key
        c.update(data) + c.final
      end
    end

    def decrypt(cipher_key, data, cipher = "AES-128-CBC")
      hex = data.gsub(/\A(@)/, '')
      input = [hex].pack('H*')
      output = cipher(:decrypt, cipher, cipher_key)[cipher, input, 0]
      output.gsub(/\005/, '').gsub("\r", '').gsub("\n", '')
    end

    def encrypt(cipher_key, data, cipher = "AES-128-CBC")
      _encrypted = cipher(:encrypt, cipher, cipher_key)[cipher, data, 1]
      "@#{_encrypted.unpack('H*').first.upcase}"
    end

  end

end
