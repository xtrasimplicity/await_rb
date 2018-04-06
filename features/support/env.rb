require 'simplecov'
require 'cucumber/rspec/doubles'

class StringIO
  def empty?
    string.nil? || string.empty?
  end
end

class NilClass
  def empty?
    nil?
  end
end


After do |scenario|
  if scenario.failed?
    unless @task_stdout.empty?
      puts "==== Task stdout Stream ===="
      puts @task_stdout.string
    end

    unless @task_stderr.empty?
      puts "==== Task stderr Stream ===="
      puts @task_stderr.string
    end
  end
end