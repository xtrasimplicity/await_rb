require 'timeout'
require 'socket'

namespace :await do
  TIMEOUT_SECONDS = (ENV['timeout'] || 600).to_i # Default to 10 minutes

  puts "Set timeout to #{TIMEOUT_SECONDS} seconds."

  desc "Waits for a service to respond to a particular TCP port, and then exits (with an exit code of 0)."
  task :tcp do
    host = ENV['host'] || '127.0.0.1'
    port = ENV['port'].to_s

    abort 'A port must be specified.' if port.empty?

    begin
      Timeout::timeout(TIMEOUT_SECONDS) do
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
    rescue Timeout::Error => e
      STDERR.puts "A connection to #{host} on port #{port} (TCP) could not be established within #{TIMEOUT_SECONDS} seconds."
      exit 1
    end
  end
end