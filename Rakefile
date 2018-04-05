require "bundler/gem_tasks"

begin
  require 'cucumber/rake/task'
  require 'rspec/core/rake_task'
  Cucumber::Rake::Task.new(:features)
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  abort 'Please make sure Cucumber and RSpec are installed'
end

task :default => [:spec, :features]
