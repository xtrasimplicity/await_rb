Feature: Testing services using TCP
  Scenario: A service is listening at the specified port
    Given A service is listening on TCP port 65520 at '127.0.0.1'
    When I run the 'await:tcp' rake task with the 'port=65520,host=127.0.0.1' environment variables
    Then the exit code should be 0

  Scenario: A service is not listening at the specified port
    Given A service is not listening on TCP port 65520 at '127.0.0.1'
    When I run the 'await:tcp' rake task with the 'port=65520,host=127.0.0.1' environment variables
    Then the exit code should be 1

  @mock-connection-timeout
  Scenario: A connection attempt to the specified host and port combination times out
    Given A service is listening on TCP port 65520 at '127.0.0.1'
    When I run the 'await:tcp' rake task with the 'port=65520,host=127.0.0.1,timeout=10' environment variables
    Then the exit code should be 1
    And the stderr stream should contain:
    """
    A connection to 127.0.0.1 on port 65520 (TCP) could not be established within 10 seconds.
    """