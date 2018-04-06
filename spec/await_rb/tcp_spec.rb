require 'spec_helper'
require 'socket'
require 'support/tcp_helpers'

RSpec.describe AwaitRb::Protocol::TCP do
  include TCPHelpers

  describe '.active?' do
    context 'when a port isn\'t supplied' do
      it 'raises an error' do
        expect { AwaitRb::Protocol::TCP.active?('127.0.0.1', nil) }.to raise_error
      end
    end

    context 'when a host isn\'t supplied' do
      let(:port) { 22 }
      before { allow_any_instance_of(TCPSocket).to receive(:close).and_return(true) }

      it 'defaults to `127.0.0.1`' do
        expect(TCPSocket).to receive(:new).with('127.0.0.1', port).and_call_original

        AwaitRb::Protocol::TCP.active?(nil, port)
      end
    end

    context 'when a service is listening on the port' do
      let(:port) { 22 }
      let(:host) { '192.168.1.1' }
      before { mock_service_is_listening(host, port) }

      subject { AwaitRb::Protocol::TCP.active?(host, port) }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when a service is not listening on the port' do
      let(:port) { 22 }
      let(:host) { '192.168.1.1' }
      before { mock_service_is_not_listening(host, port) }

      subject { AwaitRb::Protocol::TCP.active?(host, port) }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

  end
end