require 'socket'
require 'ostruct'

module TCPHelpers
  def mock_service_is_listening(host, port)
    # Temporary 'hack' to ensure it works when we pass either a string or an integer to 'port'
    ports = [port.to_i, port.to_s]

    ports.each do |port|
      allow(TCPSocket).to receive(:new).with(host, port).and_return(OpenStruct.new({
        close: true
      }))
    end
  end

  def mock_service_is_not_listening(host, port)
    allow(TCPSocket).to receive(:new).and_raise Errno::ECONNREFUSED
  end
end