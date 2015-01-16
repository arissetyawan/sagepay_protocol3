require 'openssl'

module SagepayProtocol3

  module Encryption
    extend self

    def cipher(operation, cipher, cipher_key)
      lambda do |data, padding|
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
      output = cipher(:decrypt, cipher, cipher_key)[input, 0]
      sanitize_payload output
    end

    def encrypt(cipher_key, data, cipher = "AES-128-CBC")
      _encrypted = cipher(:encrypt, cipher, cipher_key)[data, 1]
      "@#{_encrypted.unpack('H*').first.upcase}"
    end

    def sanitize_payload(string)
      string.gsub(/\005/, '').gsub("\r", '').gsub("\n", '')
    end

    def to_h(crypt_string)
      Hash[*crypt_string.split(/[=&]/).reject(&:blank?)]
    end
  end

end
