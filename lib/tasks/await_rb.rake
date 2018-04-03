require 'timeout'
require 'socket'

namespace :await do
  DEFAULT_TIMEOUT = 600 # 10 Minutes

  desc "Waits for a service to respond to a particular TCP port, and then exits (with an exit code of 0)."
  task :tcp do
    host = ENV['host'] || '127.0.0.1'
    port = ENV['port'].to_s

    abort 'A port must be specified.' if port.empty?

    Timeout::timeout(DEFAULT_TIMEOUT) do
      puts "Waiting for #{host} to respond to TCP port #{port}..."

      begin
        s = TCPSocket.new(host, port)
        s.close
        
        puts "The service is listening! Quitting..."
        exit 0
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        retry
      end
    end
  end
end