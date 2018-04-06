When("I run the {string} rake task with the {string} environment variables") do |rake_task, environment_variables|
  # Ensure rake task output is written to a variable rather than the console
  old_stdout = $stdout
  old_stderr = $stderr
  $stdout = StringIO.new
  $stderr = StringIO.new

  @exit_code = invoke_rake_task(rake_task, env_vars: environment_variables)

  # Store the rake task output, so we can print it in the `After` hook
  @task_stdout = $stdout
  @task_stderr = $stderr

  # Restore the standard streams
  $stdout = old_stdout
  $stderr = old_stderr
end

Then("the exit code should be {int}") do |expected_exit_code|
  expect(@exit_code).to eq(expected_exit_code)
end

Then("the stderr stream should contain:") do |content|
  expect(@task_stderr).to be_a_kind_of(StringIO)
  
  expect(@task_stderr.string).to include(content)
end