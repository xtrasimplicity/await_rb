require File.expand_path('../../../spec/support/tcp_helpers', __FILE__)
World(TCPHelpers)

Given(/A service is( not)? listening on TCP port (\d+) at \'(.*)\'$/) do |negate, port, host|
  if negate
    mock_service_is_not_listening(host, port)
  else
    mock_service_is_listening(host, port)
  end
end