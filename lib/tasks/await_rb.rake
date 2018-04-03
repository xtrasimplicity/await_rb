require 'timeout'
require 'socket'

namespace :await do
  desc "Wait for a service to respond to a particular TCP port"
  task :tcp do
    host = ENV['AWAIT_HOST'] || '127.0.0.1'
    port = ENV['AWAIT_PORT'].to_s
    cmd_to_execute = ENV['AWAIT_CMD'].to_s

    abort 'A port must be specified.' if port.empty?
    abort 'A command must be specified.' if cmd_to_execute.empty?

    Timeout::timeout(600) do
      puts "Waiting for #{host} to respond to TCP port #{port}..."

      begin
        s = TCPSocket.new(host, port)
        s.close
        
        puts "The service is listening! Running `#{cmd_to_execute}`..."
        system cmd_to_execute
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        retry
      end
    end
  end
end