module AwaitRb::Protocol
  module TCP
    require 'socket'

    def self.active?(host, port)
      host = host || '127.0.0.1'
      
      raise 'A port must be supplied' if port.to_s.empty?

      begin
        s = TCPSocket.new(host, port)
        s.close

        true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        return false
      end
    end
  end
end