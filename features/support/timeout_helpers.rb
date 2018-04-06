require 'timeout'

module TimeoutHelper
  BACKUP_TIMEOUT_METHOD_NAME = :timeout_backup
  
  def self.force_timeout
    # Backup the existing `timeout` method
    Timeout.class_eval { singleton_class.send(:alias_method, BACKUP_TIMEOUT_METHOD_NAME, :timeout) }

    # Override the `timeout` method
    Timeout.define_singleton_method(:timeout) do |*args|
      send(BACKUP_TIMEOUT_METHOD_NAME, *args) { raise Timeout::Error }
    end
  end

  def self.restore_timeout_method
    Timeout.class_eval do
      singleton_class.send(:alias_method, :timeout, BACKUP_TIMEOUT_METHOD_NAME)
    end
  end
end

Before('@mock-connection-timeout') do
  TimeoutHelper.force_timeout
end

After('@mock-connection-timeout') do
  TimeoutHelper.restore_timeout_method
end