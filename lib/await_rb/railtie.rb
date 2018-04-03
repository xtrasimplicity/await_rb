require "rails"

module AwaitRb
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), "../tasks/await_rb.rake")
    end
  end
end