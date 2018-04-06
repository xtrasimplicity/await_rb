require 'timeout'
require 'socket'
require 'await_rb'

namespace :await do

  desc "Waits for a service to respond to a particular TCP port, and then exits (with an exit code of 0)."
  task :tcp do
    host = ENV['host']
    port = ENV['port']

    timeout_seconds = (ENV['timeout'] || 600).to_i # Default to 10 minutes
    puts "Set timeout to #{timeout_seconds} seconds."

    begin
      Timeout::timeout(timeout_seconds) do
        begin
          if AwaitRb::Protocol::TCP.active?(host, port)
            exit 0
          else
            exit 1
          end
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          retry
        end
      end
    rescue Timeout::Error => e
      $stderr.puts "A connection to #{host} on port #{port} (TCP) could not be established within #{timeout_seconds} seconds."
      exit 1
    end
  end
end