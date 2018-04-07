# frozen_string_literal: true
require 'optparse'

module AwaitRb
  module Cli
    class Main
      def initialize(args)
        ARGV << '--help' if ARGV.empty?
        prepare_usage_info
      end

      def run!
        
      end

      private

      def prepare_usage_info
        OptionParser.new do |opts|
          opts.banner = 'Usage: await-rb [options]'

          opts.on('-h', '--host [host]', 'Host') { |host| @host = host }
          opts.on('--pr', '--protocol [protocol]', 'The protocol to use') { |protocol| @protocol = protocol }
          opts.on('-p', '--port [port]', 'Port') { |port| @port = port }

          opts.on('--help') do
            puts opts
            exit 1
          end
        end.parse!
      end
    end
  end
end