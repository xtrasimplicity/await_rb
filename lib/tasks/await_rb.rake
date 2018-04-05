require 'timeout'
require 'socket'
require 'await_rb'

namespace :await do
  TIMEOUT_SECONDS = (ENV['timeout'] || 600).to_i # Default to 10 minutes

  puts "Set timeout to #{TIMEOUT_SECONDS} seconds."

  desc "Waits for a service to respond to a particular TCP port, and then exits (with an exit code of 0)."
  task :tcp do
    if AwaitRb::Protocol::TCP.active?(host: ENV['host'], port: ENV['port'])
      exit 0
    else
      exit 1
    end
  end
end